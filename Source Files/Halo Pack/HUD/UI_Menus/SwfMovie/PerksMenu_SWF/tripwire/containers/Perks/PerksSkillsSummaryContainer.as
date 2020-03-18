package tripwire.containers.Perks
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import tripwire.controls.TripButton;
   import tripwire.managers.MenuManager;
   
   public class PerksSkillsSummaryContainer extends PerkContainerBase
   {
       
      
      public var configureButton:TripButton;
      
      public var titleTextfield:TextField;
      
      public var skillList:ScrollingList;
      
      public var owner:MovieClip;
      
      public function PerksSkillsSummaryContainer()
      {
         super();
         ANIM_OFFSET_X = 0;
         if(this.skillList.scrollBar != null)
         {
            this.skillList.scrollBar.visible = false;
         }
         this.skillList.mouseEnabled = false;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         defaultNumPrompts = !!MenuManager.manager.bOpenedInGame?5:4;
         super.addedToStage(param1);
         this.setTabIndex();
      }
      
      private function setTabIndex() : void
      {
         this.configureButton.tabEnabled = false;
      }
      
      override public function selectContainer() : void
      {
         super.selectContainer();
         this.updateControllerIconVisibility();
      }
      
      override protected function onInputChange(param1:Event) : *
      {
         super.onInputChange(param1);
         this.updateControllerIconVisibility();
      }
      
      private function updateControllerIconVisibility() : void
      {
         this.configureButton.visible = !bManagerUsingGamepad;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled || !visible)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN && !MenuManager.manager.bPopUpOpen && this.owner.bSelected)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.GAMEPAD_X:
                  this.configureButton.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
            }
         }
      }
      
      public function set bTierUnlocked(param1:Boolean) : *
      {
         var _loc2_:MovieClip = this.configureButton.getChildByName("highlightBG") as MovieClip;
         if(param1)
         {
            _loc2_.gotoAndPlay("Glow");
         }
         else
         {
            _loc2_.gotoAndStop("Off");
         }
      }
      
      public function set skillsData(param1:Array) : *
      {
         if(param1 != null)
         {
            this.skillList.dataProvider = new DataProvider(param1);
            if(this.skillList.scrollBar != null)
            {
               this.skillList.scrollBar.visible = param1.length - 1 > this.skillList.rowCount;
            }
         }
      }
   }
}
