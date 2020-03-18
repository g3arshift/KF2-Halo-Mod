package tripwire.containers.Perks
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.managers.FocusHandler;
   import scaleform.gfx.FocusManager;
   import tripwire.containers.SectionHeaderContainer;
   import tripwire.controls.perks.PerkSelectLineRenderer;
   import tripwire.managers.MenuManager;
   
   public class PerkSelectionContainer extends PerkContainerBase
   {
       
      
      public var owner;
      
      public var perkScrollingList:ScrollingList;
      
      public var perkSelectBlocker;
      
      public var pendingPerkBox;
      
      public var header:SectionHeaderContainer;
      
      public var currentPerk:int = -1;
      
      private var _bLostFocus:Boolean = false;
      
      private var _bFirstChange:Boolean = true;
      
      private var _bPerkListEnabled:Boolean = true;
      
      public function PerkSelectionContainer()
      {
         super();
         defaultFirstElement = this.perkScrollingList;
      }
      
      public function set localizedText(param1:Object) : void
      {
         if(param1)
         {
            this.perkSelectBlocker.descriptionTextfield.text = !!param1.oncePerkWave?param1.oncePerkWave:"";
            this.header.text = !!param1.header?param1.header:"";
         }
      }
      
      public function setTabIndex() : void
      {
         this.perkScrollingList.tabIndex = 1;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.setTabIndex();
         if(this.pendingPerkBox != null)
         {
            this.pendingPerkBox.visible = false;
         }
         this.perkScrollingList.addEventListener(ListEvent.ITEM_CLICK,this.onPerkClick,false,0,true);
         this.perkScrollingList.addEventListener(ListEvent.INDEX_CHANGE,this.onPerkChanged,false,0,true);
      }
      
      public function get perkListEnabled() : Boolean
      {
         return this._bPerkListEnabled;
      }
      
      public function set perkListEnabled(param1:Boolean) : void
      {
         this.perkScrollingList.selectedIndex = this.currentPerk;
         this.perkScrollingList.focusable = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.perkScrollingList.dataProvider.length)
         {
            PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(_loc2_)).enabled = param1;
            PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(_loc2_)).selected = false;
            PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(_loc2_)).active = false;
            PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(_loc2_)).stateOverride = !!param1?"up":"disabled";
            _loc2_++;
         }
         PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(this.currentPerk)).enabled = true;
         PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(this.currentPerk)).active = true;
         PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(this.currentPerk)).selected = true;
         PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(this.currentPerk)).stateOverride = !!bManagerUsingGamepad?"over":"up";
         if(bManagerUsingGamepad && !MenuManager.manager.bPopUpOpen && _bOpen)
         {
            FocusHandler.getInstance().setFocus(PerkSelectLineRenderer(this.perkScrollingList.getRendererAt(this.currentPerk)));
         }
         this._bPerkListEnabled = param1;
         dispatchEvent(new Event("perkListEnabledUpdated",true));
      }
      
      public function setPendingPerkChanges(param1:String, param2:String, param3:String) : void
      {
         if(param1 != null && param1 != "")
         {
            this.pendingPerkBox.visible = true;
            this.pendingPerkBox.pendingPerkTextField.text = param1;
            this.pendingPerkBox.notificationTextfield.text = param3;
            this.pendingPerkBox.iconLoader.source = param2;
         }
         else
         {
            this.pendingPerkBox.visible = false;
            this.pendingPerkBox.pendingPerkTextField.text = "";
         }
      }
      
      public function onPerkClick(param1:ListEvent) : *
      {
         if(param1.index != this.currentPerk)
         {
            TweenMax.killTweensOf(this);
            this.perkScrollingList.selectedIndex = param1.index;
            if(bManagerUsingGamepad)
            {
               this.swapPerkInfo(param1.index,true);
            }
            else
            {
               TweenMax.to(this,ANIM_TIME,{
                  "useFrames":true,
                  "onComplete":this.swapPerkInfo,
                  "onCompleteParams":[param1.index,true]
               });
               dispatchEvent(new Event("changePerk",true));
            }
            FocusHandler.getInstance().setFocus(this.perkScrollingList);
            FocusManager.setModalClip(this.perkScrollingList);
         }
      }
      
      public function onPerkChanged(param1:ListEvent) : *
      {
         if(bManagerUsingGamepad && this.perkScrollingList.hasFocus && !this._bFirstChange)
         {
            TweenMax.killTweensOf(this);
            TweenMax.to(this,ANIM_TIME,{
               "useFrames":true,
               "onComplete":this.swapPerkInfo,
               "onCompleteParams":[param1.index,false]
            });
            dispatchEvent(new Event("changePerk",true));
            FocusHandler.getInstance().setFocus(this.perkScrollingList);
            FocusManager.setModalClip(this.perkScrollingList);
         }
         this._bLostFocus = !this.perkScrollingList.hasFocus;
         this._bFirstChange = false;
      }
      
      public function get SelectedIndex() : int
      {
         return this.perkScrollingList.selectedIndex;
      }
      
      public function set SelectedIndex(param1:int) : *
      {
         var _loc2_:PerkSelectLineRenderer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.perkScrollingList.dataProvider.length)
         {
            _loc2_ = this.perkScrollingList.getRendererAt(_loc3_) as PerkSelectLineRenderer;
            if(_loc3_ == param1)
            {
               if(bManagerUsingGamepad && !MenuManager.manager.bPopUpOpen)
               {
                  FocusHandler.getInstance().setFocus(_loc2_);
                  FocusManager.setModalClip(this.perkScrollingList);
               }
            }
            _loc3_++;
         }
         this.perkScrollingList.selectedIndex = param1;
      }
      
      public function set ActiveIndex(param1:int) : *
      {
         var _loc2_:PerkSelectLineRenderer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.perkScrollingList.dataProvider.length)
         {
            _loc2_ = this.perkScrollingList.getRendererAt(_loc3_) as PerkSelectLineRenderer;
            if(_loc3_ == param1)
            {
               this.currentPerk = _loc3_;
               _loc2_.active = true;
            }
            else
            {
               _loc2_.active = false;
            }
            _loc3_++;
         }
         if(this.owner)
         {
            this.owner.updatePrompts();
         }
      }
      
      public function set perkData(param1:Array) : *
      {
         this.perkScrollingList.dataProvider = new DataProvider(param1);
         this.perkScrollingList.validateNow();
         this.perkScrollingList.scrollBar.visible = this.perkScrollingList.dataProvider.length > this.perkScrollingList.rowCount;
      }
      
      public function swapPerkInfo(param1:int, param2:Boolean) : void
      {
         ExternalInterface.call("Callback_PerkSelected",param1,param2);
      }
      
      override public function selectContainer() : void
      {
         defaultNumPrompts = !!MenuManager.manager.bOpenedInGame?5:4;
         super.selectContainer();
      }
   }
}
