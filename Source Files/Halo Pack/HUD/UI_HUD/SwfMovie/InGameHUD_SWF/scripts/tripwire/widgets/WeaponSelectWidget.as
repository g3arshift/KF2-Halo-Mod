package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import tripwire.containers.WeaponSelectGroupContainer;
   import flash.utils.Timer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import scaleform.clik.motion.Tween;
   import tripwire.managers.HudManager;
   import flash.external.ExternalInterface;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   
   public class WeaponSelectWidget extends UIComponent
   {
       
      
      public var bIsControllerVersion:Boolean = false;
      
      public var throwIndicator;
      
      public var WeaponCategoryContainer0:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainer1:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainer2:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainer3:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainerGamePad0:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainerGamePad1:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainerGamePad2:WeaponSelectGroupContainer;
      
      public var WeaponCategoryContainerGamePad3:WeaponSelectGroupContainer;
      
      private const MAX_WEAPON_GROUPS = 4;
      
      private const FADE_TIME = 0.8;
      
      private var _bStayOpen:Boolean;
      
      protected var _currentGroupIndex:int;
      
      protected var _currentSelectedIndex:int;
      
      protected var _bFadingOut:Boolean;
      
      protected var weaponGroupContainers:Vector.<WeaponSelectGroupContainer>;
      
      protected var _weaponSelectFadeTimer:Timer;
      
      public function WeaponSelectWidget()
      {
         super();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         enableInitCallback = true;
         this.weaponGroupContainers = new Vector.<WeaponSelectGroupContainer>();
         this._weaponSelectFadeTimer = new Timer(this.FADE_TIME * 1000,1);
         this._weaponSelectFadeTimer.addEventListener(TimerEvent.TIMER,this.close,false,0,true);
         this.updateContainerList();
         visible = false;
         this.z = 112;
         this.alpha = 0;
         this.throwIndicator.visible = false;
      }
      
      public function set throwString(param1:String) : void
      {
         this.throwIndicator.textfield.text = param1;
      }
      
      private function updateContainerList() : *
      {
         var _loc1_:Array = new Array();
         var _loc2_:Vector.<WeaponSelectGroupContainer> = this.weaponGroupContainers;
         this.weaponGroupContainers = new Vector.<WeaponSelectGroupContainer>();
         var _loc3_:int = 0;
         while(_loc3_ < this.MAX_WEAPON_GROUPS)
         {
            this.weaponGroupContainers.push(this["WeaponCategoryContainer" + _loc3_]);
            if(_loc2_ != null && _loc2_.length > 0)
            {
               this.weaponGroupContainers[_loc3_].header = _loc2_[_loc3_].header;
               this.setWeaponList(_loc2_[_loc3_].weaponList,_loc3_);
            }
            else
            {
               this.setWeaponList(_loc1_,_loc3_);
            }
            _loc3_++;
         }
      }
      
      public function open() : void
      {
         visible = true;
         this.WeaponBlurClear();
         Tween.removeAllTweens();
         this.WeaponBlurIn();
         this._weaponSelectFadeTimer.reset();
         this._weaponSelectFadeTimer.start();
         if(HudManager.manager != null && HudManager.manager.RhythmCounter != null)
         {
            HudManager.manager.RhythmCounter.hidden = true;
         }
         this.WeaponCategoryContainer0.bControllerParent = this.bIsControllerVersion;
         this.WeaponCategoryContainer1.bControllerParent = this.bIsControllerVersion;
         this.WeaponCategoryContainer2.bControllerParent = this.bIsControllerVersion;
         this.WeaponCategoryContainer3.bControllerParent = this.bIsControllerVersion;
      }
      
      public function close(param1:TimerEvent = null) : *
      {
         if(!this._bStayOpen)
         {
            this._bFadingOut = true;
            this.WeaponBlurClear();
            Tween.removeAllTweens();
            this.WeaponBlurOut();
            this.onFadeOutComplete();
            HudManager.manager.RhythmCounter.hidden = false;
         }
      }
      
      public function set bStayOpen(param1:*) : *
      {
         this._bStayOpen = param1;
         if(!param1)
         {
            this.close();
         }
         else
         {
            this.open();
            this.showAllElementsInGroups();
         }
      }
      
      public function set weaponCategories(param1:Object) : void
      {
         this.WeaponCategoryContainer0.header = param1.Primary;
         this.WeaponCategoryContainer1.header = param1.Backup;
         this.WeaponCategoryContainer2.header = param1.Melee;
         this.WeaponCategoryContainer3.header = param1.Equipment;
      }
      
      public function setWeaponList(param1:Array, param2:int) : void
      {
         this.weaponGroupContainers[param2].weaponList = param1;
      }
      
      public function setSelectedIndex(param1:int, param2:int) : void
      {
         if(this._currentGroupIndex != param1)
         {
            this.weaponGroupContainers[this._currentGroupIndex].unselectGroup();
         }
         this.showFirstItemOfGroups();
         if(!visible)
         {
            this.open();
         }
         else
         {
            this._weaponSelectFadeTimer.reset();
            this._weaponSelectFadeTimer.start();
            if(this._bFadingOut)
            {
               this._bFadingOut = false;
               this.WeaponBlurClear();
               Tween.removeAllTweens();
               this.WeaponBlurIn();
            }
         }
         this.updateIndex(param1,param2);
      }
      
      public function showFirstItemOfGroups() : *
      {
         var _loc1_:WeaponSelectGroupContainer = null;
         for each(_loc1_ in this.weaponGroupContainers)
         {
            _loc1_.showFirstElement();
         }
      }
      
      public function showAllElementsInGroups() : *
      {
         var _loc1_:WeaponSelectGroupContainer = null;
         for each(_loc1_ in this.weaponGroupContainers)
         {
            _loc1_.showAllElements();
         }
      }
      
      public function updateIndex(param1:int, param2:int) : *
      {
         this._currentGroupIndex = param1;
         this._currentSelectedIndex = param2;
         this.weaponGroupContainers[param1].selectedIndex = param2;
         this.weaponGroupContainers[param1].alpha = 1;
      }
      
      public function showOnlyHUDGroup(param1:int) : void
      {
         var _loc2_:int = 0;
         this.open();
         while(_loc2_ < this.weaponGroupContainers.length)
         {
            if(param1 == _loc2_)
            {
               this.weaponGroupContainers[_loc2_].visible = true;
            }
            else
            {
               this.weaponGroupContainers[_loc2_].visible = false;
            }
            _loc2_++;
         }
         HudManager.manager.RhythmCounter.hidden = true;
      }
      
      public function showAllHUDGroups() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.weaponGroupContainers.length)
         {
            this.open();
            if(!this.weaponGroupContainers[_loc1_].visible)
            {
               this.weaponGroupContainers[_loc1_].visible = true;
            }
            _loc1_++;
         }
         HudManager.manager.RhythmCounter.hidden = true;
      }
      
      private function onFadeOutComplete() : void
      {
         ExternalInterface.call("Callback_WeaponSelectFadedOut");
         HudManager.manager.RhythmCounter.hidden = false;
      }
      
      private function WeaponBlurIn() : void
      {
         TweenMax.to(this,4,{
            "alpha":0.88,
            "z":0,
            "useFrames":true,
            "ease":Cubic.easeOut
         });
      }
      
      private function WeaponFadeInFilters(param1:Tween) : void
      {
      }
      
      private function WeaponBlurOut() : void
      {
         TweenMax.to(this,4,{
            "alpha":0,
            "z":112,
            "useFrames":true,
            "ease":Cubic.easeIn
         });
      }
      
      private function WeaponFadeOutFilters(param1:Tween) : void
      {
      }
      
      private function WeaponFadeClear(param1:Tween) : void
      {
         filters = null;
      }
      
      private function WeaponBlurClear() : void
      {
      }
      
      private function testWeaponSelect() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Object = new Object();
         _loc5_.weaponName = "weapon0";
         _loc5_.texturePath = "";
         _loc5_.ammoCount = 1;
         _loc5_.spareAmmoCount = 20;
         _loc5_.bUsesAmmo = true;
         var _loc6_:Object = new Object();
         _loc6_.weaponName = "ITEM 1";
         _loc6_.texturePath = "";
         _loc6_.ammoCount = 1;
         _loc6_.spareAmmoCount = 20;
         _loc6_.bUsesAmmo = true;
         var _loc7_:Object = new Object();
         _loc7_.weaponName = "ITEM 4";
         _loc7_.texturePath = "";
         _loc7_.ammoCount = 1;
         _loc7_.spareAmmoCount = 20;
         _loc7_.bUsesAmmo = true;
         _loc1_ = new Array(_loc5_,_loc6_,_loc7_,_loc5_,_loc6_,_loc7_);
         _loc2_ = new Array(_loc5_,_loc6_,_loc7_,_loc5_,_loc6_,_loc7_);
         _loc3_ = new Array(_loc5_,_loc6_,_loc7_,_loc5_,_loc6_,_loc7_);
         _loc4_ = new Array(_loc5_,_loc6_,_loc7_,_loc5_,_loc6_,_loc7_);
         _enableInitCallback = true;
         this.setWeaponList(_loc1_,0);
         this.setWeaponList(_loc2_,1);
         this.setWeaponList(_loc3_,2);
         this.setWeaponList(_loc4_,3);
         this.setSelectedIndex(3,0);
         visible = true;
      }
   }
}
