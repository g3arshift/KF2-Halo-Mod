package tripwire.menus
{
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.FocusManager;
   import tripwire.containers.Perks.PerkDetailsContainer;
   import tripwire.containers.Perks.PerkSelectionContainer;
   import tripwire.containers.Perks.PerksConfigureSkillsContainer;
   import tripwire.containers.Perks.PerksHeaderContainer;
   import tripwire.containers.Perks.PerksNextRankContainer;
   import tripwire.containers.Perks.PerksSkillsSummaryContainer;
   import tripwire.containers.TripContainer;
   import tripwire.controls.perks.PerkSelectLineRenderer;
   import tripwire.managers.MenuManager;
   
   public class PerkSelectMenu extends TripContainer
   {
       
      
      public var SelectedPerkSummaryContainer:PerksSkillsSummaryContainer;
      
      public var HeaderContainer:PerksHeaderContainer;
      
      public var DetailsContainer:PerkDetailsContainer;
      
      public var NextRankContainer:PerksNextRankContainer;
      
      public var SkillsContainer:PerksConfigureSkillsContainer;
      
      public var SelectionContainer:PerkSelectionContainer;
      
      private var _bLocked:Boolean;
      
      public var _tempSelected:int;
      
      public var cachedSelectionIndex:int;
      
      public var bCanUseMenu:Boolean = false;
      
      public var openSkillConfigSoundEffect:String = "PERK_CONFIGURE_SKILLS_CLICK";
      
      public var openPerkDetailsSoundEffect:String = "PERK_MENU_BUTTON_CLICK";
      
      public function PerkSelectMenu()
      {
         super();
         defaultFirstElement = this.SelectionContainer.perkScrollingList;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.SelectedPerkSummaryContainer.owner = this;
         this.SelectionContainer.owner = this;
         this.SelectedPerkSummaryContainer.configureButton.addEventListener(ButtonEvent.CLICK,this.onButtonClick,false,0,true);
         this.SelectedPerkSummaryContainer.configureButton.clickSoundEffect = "SHARED_BUTTON_CLICK";
         this.SkillsContainer.confirmButton.addEventListener(ButtonEvent.CLICK,this.onButtonClick,false,0,true);
         this.addEventListener("changePerk",this.swapPerk,false,0,true);
         this.addEventListener("perkListEnabledUpdated",this.perkListStatusChanged,false,0,true);
         sectionHeader = this.SelectionContainer.header;
         this.SelectionContainer.selectContainer();
         this.openPerkDetails();
         currentElement = this.SelectionContainer.perkScrollingList;
         this.HeaderContainer.addEventListener(MouseEvent.MOUSE_OVER,handleRightSideOver,false,0,true);
         this.DetailsContainer.addEventListener(MouseEvent.MOUSE_OVER,handleRightSideOver,false,0,true);
         this.SkillsContainer.addEventListener(MouseEvent.MOUSE_OVER,handleRightSideOver,false,0,true);
         this.SelectedPerkSummaryContainer.addEventListener(MouseEvent.MOUSE_OVER,handleRightSideOver,false,0,true);
         this.SelectionContainer.addEventListener(MouseEvent.MOUSE_OVER,handleLeftSideOver,false,0,true);
         leftSidePanels.push(this.SelectionContainer);
         this.SkillsContainer.addEventListener("SkillsConfiguredSeen",this.clearGlowOnPerk,false,0,true);
      }
      
      override public function focusGroupIn() : void
      {
         super.focusGroupIn();
         this.SelectionContainer.perkScrollingList.selectedIndex = this.SelectionContainer.currentPerk;
         this.SelectionContainer.header.controllerIconVisible = !bSelected;
      }
      
      override public function focusGroupOut() : void
      {
         super.focusGroupOut();
         this.SelectionContainer.perkScrollingList.selectedIndex = -1;
         this.SelectionContainer.header.controllerIconVisible = !bSelected;
      }
      
      override public function openContainer(param1:Boolean = true) : void
      {
         super.openContainer(param1);
         this.SkillsContainer.closeContainer();
         this.SelectionContainer.openContainer();
         this.openPerkDetails();
      }
      
      override protected function onOpened(param1:TweenEvent = null) : void
      {
         super.onOpened(param1);
         this.bCanUseMenu = true;
         FocusManager.setModalClip(this.SelectionContainer.perkScrollingList);
      }
      
      override public function closeContainer() : void
      {
         super.closeContainer();
         this.bCanUseMenu = false;
         this.SkillsContainer.closeContainer();
         this.SelectionContainer.closeContainer();
         FocusManager.setModalClip(null);
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._bLocked = param1;
         this.SelectionContainer.perkSelectBlocker.visible = param1;
         this.SelectionContainer.perkScrollingList.enabled = !param1;
         this.SelectedPerkSummaryContainer.configureButton.enabled = !param1;
         if(param1)
         {
            this.closeSkillConfigure();
         }
      }
      
      public function get locked() : Boolean
      {
         return this._bLocked;
      }
      
      override protected function onBPressed(param1:InputDetails) : void
      {
         super.onBPressed(param1);
         if(this.SkillsContainer.bOpen)
         {
            this.closeSkillConfigure();
         }
         else
         {
            ExternalInterface.call("Callback_ControllerCloseMenu");
         }
      }
      
      private function openSkillConfigure() : void
      {
         if(this.SelectionContainer.currentPerk != this.SelectionContainer.SelectedIndex && bManagerUsingGamepad)
         {
            return;
         }
         if(Extensions.gfxProcessSound != null)
         {
         }
         if(!this.SelectionContainer.perkListEnabled)
         {
            return;
         }
         currentElement = this.SkillsContainer;
         TweenMax.killTweensOf([this.DetailsContainer,this.HeaderContainer,this.SelectedPerkSummaryContainer]);
         this.closePerkDetails();
         this.cachedSelectionIndex = this.SelectionContainer.SelectedIndex;
         this.SelectionContainer.deselectContainer();
         this.SelectionContainer.SelectedIndex = -1;
         TweenMax.to(this,ANIM_TIME,{
            "useFrames":true,
            "onComplete":this.SkillsContainer.openContainer
         });
         showDimLeftSide(true);
         FocusManager.setModalClip(this.SkillsContainer);
         containerDisplayPrompts = 2;
         this.clearGlowOnPerk(null);
      }
      
      public function clearGlowOnPerk(param1:Event) : void
      {
         var _loc2_:PerkSelectLineRenderer = null;
         _loc2_ = PerkSelectLineRenderer(this.SelectionContainer.perkScrollingList.getRendererAt(this.SelectionContainer.perkScrollingList.selectedIndex));
         if(_loc2_)
         {
            _loc2_.glowActive = false;
         }
      }
      
      private function closeSkillConfigure() : void
      {
         currentElement = this.SelectionContainer.perkScrollingList;
         this.SkillsContainer.closeContainer();
         this.SelectionContainer.SelectedIndex = this.cachedSelectionIndex;
         this.SelectionContainer.selectContainer();
         TweenMax.to(this,ANIM_TIME,{
            "useFrames":true,
            "onComplete":this.openPerkDetails
         });
         showDimLeftSide(false);
         this.updatePrompts();
      }
      
      private function openPerkDetails() : void
      {
         this.DetailsContainer.openContainer();
         this.HeaderContainer.openContainer();
         this.SelectedPerkSummaryContainer.openContainer();
      }
      
      private function closePerkDetails() : void
      {
         this.DetailsContainer.closeContainer();
         this.HeaderContainer.closeContainer();
         this.SelectedPerkSummaryContainer.closeContainer();
      }
      
      public function onButtonClick(param1:ButtonEvent) : void
      {
         if(!this.bCanUseMenu)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case this.SelectedPerkSummaryContainer.configureButton:
               this.openSkillConfigure();
               break;
            case this.SkillsContainer.confirmButton:
               this.closeSkillConfigure();
         }
      }
      
      public function swapPerk(param1:Event) : void
      {
         if(this.SkillsContainer.visible)
         {
            this.SkillsContainer.closeContainer();
            if(!bManagerUsingGamepad)
            {
               this.cachedSelectionIndex = this.SelectionContainer.SelectedIndex;
               TweenMax.to(this,ANIM_TIME,{
                  "useFrames":true,
                  "onComplete":this.SkillsContainer.openContainer
               });
            }
            if(Extensions.gfxProcessSound != null)
            {
            }
         }
         else
         {
            this.closePerkDetails();
            TweenMax.to(sectionHeader,ANIM_TIME,{
               "useFrames":true,
               "onComplete":this.openPerkDetails
            });
            if(Extensions.gfxProcessSound != null)
            {
               Extensions.gfxProcessSound(this,"UI",this.openPerkDetailsSoundEffect);
            }
         }
         this.updatePrompts();
      }
      
      public function perkListStatusChanged(param1:Event) : void
      {
         if(this.SkillsContainer.visible)
         {
            this.SkillsContainer.closeContainer();
            TweenMax.to(this,ANIM_TIME,{
               "useFrames":true,
               "onComplete":this.openPerkDetails
            });
            showDimLeftSide(false);
         }
         this.SelectedPerkSummaryContainer.configureButton.enabled = this.SelectionContainer.perkListEnabled;
         this.updatePrompts();
      }
      
      public function updatePrompts() : *
      {
         if(bManagerUsingGamepad)
         {
            containerDisplayPrompts = this.SelectionContainer.currentPerk == this.SelectionContainer.SelectedIndex && this.SelectionContainer.perkListEnabled?int(defaultNumPrompts):1;
         }
      }
      
      override public function selectContainer() : void
      {
         defaultNumPrompts = !!MenuManager.manager.bOpenedInGame?5:4;
         super.selectContainer();
         if(_bOpen)
         {
            this.SelectionContainer.header.controllerIconVisible = !bSelected;
            if(this.SkillsContainer.bSelected)
            {
               this.SkillsContainer.selectContainer();
            }
            showDimLeftSide(false);
         }
      }
   }
}
