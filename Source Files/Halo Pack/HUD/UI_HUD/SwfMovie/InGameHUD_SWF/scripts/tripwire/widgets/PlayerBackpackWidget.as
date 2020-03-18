package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import scaleform.clik.controls.UILoader;
   import flash.text.TextField;
   import fl.motion.Color;
   import flash.events.Event;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import flash.text.TextLineMetrics;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class PlayerBackpackWidget extends UIComponent
   {
       
      
      private var _barkDosh:int;
      
      private var _doshTotal:int;
      
      public var AmmoContainer:MovieClip;
      
      public var DoshContainer:MovieClip;
      
      public var FlashlightContainer:MovieClip;
      
      public var GrenadeContainer:MovieClip;
      
      public var secondaryAmmoContainer:MovieClip;
      
      public var firemodeLoader:UILoader;
      
      public var weightTextField:TextField;
      
      private var _storedAmmoTF:TextField = null;
      
      private var _magazineAmmoTF:TextField = null;
      
      private var _grenadesTF:TextField = null;
      
      private var _doshTF:TextField = null;
      
      private var _flashlightBatteryMC:MovieClip = null;
      
      private var _flashlightIconMC:MovieClip = null;
      
      private var _ammoContainerMC:MovieClip = null;
      
      private var _doshGaugeMC:MovieClip = null;
      
      private var _doshBarkMC:MovieClip = null;
      
      private var _doshBarkInfoMC:MovieClip = null;
      
      private var _secondaryAmmoTF:TextField = null;
      
      private var _secondaryLoader:UILoader = null;
      
      private var _grenadeIconLoader:UILoader = null;
      
      private var _doshBarkPrefix:TextField = null;
      
      private var _doshBarkText:TextField = null;
      
      private var whiteColor:uint = 16503487;
      
      private var greenColor:uint = 4836490;
      
      private var redColor:uint = 16745317;
      
      private var doshBarkIconColor:Color;
      
      public var doshObj:Object;
      
      public const doshBarkXOffset:int = 64;
      
      public const doshBarkStartY:int = -56;
      
      public const doshBarkYOffset:int = 8;
      
      public const doshBarkDelayTime:int = 45;
      
      public const doshBarkTweenTime:int = 8;
      
      public function PlayerBackpackWidget()
      {
         this.doshBarkIconColor = new Color();
         this.doshObj = {"doshNum":0};
         super();
         _enableInitCallback = true;
         this.cacheBackpackWidgets();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.bUsesAmmo = false;
         this.bUsesSecondaryAmmo = false;
         this.resetDoshBark();
      }
      
      private function cacheBackpackWidgets() : *
      {
         this._secondaryAmmoTF = this.secondaryAmmoContainer.ammoTextField;
         this._secondaryLoader = this.secondaryAmmoContainer.secondaryLoader;
         this._ammoContainerMC = this.AmmoContainer;
         this._storedAmmoTF = this.AmmoContainer.AmmoInfo.StoredAmmoTextField;
         this._magazineAmmoTF = this.AmmoContainer.AmmoInfo.CurrentAmmoTextField;
         this._grenadesTF = this.GrenadeContainer.GrenadeInfo.GrenadeTextField;
         this._grenadeIconLoader = this.GrenadeContainer.GrenadeInfo.GrenadeIcon;
         this._doshTF = this.DoshContainer.DoshGaugeInfo.DoshGaugeMC.DoshTextField;
         this._flashlightBatteryMC = this.FlashlightContainer.FlashlightBarContainer;
         this._flashlightIconMC = this.FlashlightContainer.FlashlightIcon;
         this._doshGaugeMC = this.DoshContainer.DoshGaugeInfo;
         this._doshBarkMC = this.DoshContainer.DoshBark;
         this._doshBarkPrefix = this.DoshContainer.DoshBark.DoshPrefix;
         this._doshBarkText = this.DoshContainer.DoshBark.DoshTextField;
      }
      
      public function set WeightText(param1:String) : void
      {
         this.weightTextField.text = param1;
      }
      
      public function set bUsesAmmo(param1:Boolean) : void
      {
         if(param1)
         {
            this._storedAmmoTF.visible = true;
            this._magazineAmmoTF.visible = true;
            this.AmmoContainer.AmmoInfo.AmmoGaugeConnector.visible = true;
            this.AmmoContainer.AmmoInfo.AmmoMelee.visible = false;
         }
         else
         {
            this._storedAmmoTF.visible = false;
            this._magazineAmmoTF.visible = false;
            this.AmmoContainer.AmmoInfo.AmmoGaugeConnector.visible = false;
            this.AmmoContainer.AmmoInfo.AmmoMelee.visible = true;
         }
      }
      
      public function set secondaryAmmo(param1:int) : void
      {
         this._secondaryAmmoTF.text = param1.toString();
      }
      
      public function set secondaryIcon(param1:String) : void
      {
         this._secondaryLoader.source = param1;
      }
      
      public function set bUsesSecondaryAmmo(param1:Boolean) : void
      {
         this.secondaryAmmoContainer.visible = param1;
      }
      
      public function set backpackStoredAmmo(param1:int) : void
      {
         this._storedAmmoTF.text = param1.toString();
      }
      
      public function set weaponMagazineAmmo(param1:int) : void
      {
         this._magazineAmmoTF.text = param1.toString();
      }
      
      public function set backpackDosh(param1:int) : void
      {
         TweenMax.killTweensOf(this._doshBarkMC);
         this._barkDosh = this._barkDosh + param1;
         this.tintBarkDosh(this._barkDosh);
         this._doshBarkText.text = String(Math.abs(this._barkDosh));
         this.moveBarkDoshItems();
         if(!this._doshBarkMC.visible)
         {
            this._doshBarkMC.visible = true;
            TweenMax.set(this._doshBarkMC,{
               "x":"+" + String(this.doshBarkXOffset),
               "y":this.doshBarkStartY
            });
            TweenMax.to(this._doshBarkMC,this.doshBarkTweenTime,{
               "x":0,
               "alpha":1,
               "useFrames":true,
               "ease":Expo.easeOut
            });
         }
         else
         {
            this._doshBarkMC.y = this.doshBarkStartY;
            this._doshBarkMC.alpha = 1;
         }
         TweenMax.to(this._doshBarkMC,this.doshBarkTweenTime,{
            "delay":this.doshBarkDelayTime,
            "alpha":0,
            "y":String(this.doshBarkYOffset),
            "useFrames":true,
            "onComplete":this.resetDoshBark
         });
         this._doshTotal = this._doshTotal + param1;
         TweenMax.fromTo(this.doshObj,this.doshBarkTweenTime,{"doshNum":parseInt(this._doshTF.text)},{
            "doshNum":this._doshTotal,
            "onUpdate":this.changeDosh,
            "useFrames":true
         });
      }
      
      public function tintBarkDosh(param1:int) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1 >= 0?uint(this.greenColor):uint(this.redColor);
         this._doshBarkPrefix.text = param1 >= 0?"+":"-";
         this._doshBarkPrefix.textColor = _loc2_;
         this._doshBarkText.textColor = _loc2_;
         this.doshBarkIconColor.setTint(_loc2_,1);
         this._doshBarkMC.DoshBarkIcon.transform.colorTransform = this.doshBarkIconColor;
      }
      
      public function moveBarkDoshItems() : void
      {
         var _loc1_:TextLineMetrics = this._doshBarkText.getLineMetrics(0);
         var _loc2_:Number = 0 - _loc1_.width;
         this._doshBarkMC.DoshBarkIcon.x = _loc2_ - 35;
         this._doshBarkPrefix.x = _loc2_ - 65;
      }
      
      public function changeDosh() : void
      {
         this._doshTF.text = int(this.doshObj.doshNum).toString();
      }
      
      public function resetDoshBark() : void
      {
         this._barkDosh = 0;
         this._doshBarkMC.visible = false;
         this._doshBarkMC.alpha = 0;
      }
      
      public function set backpackGrenades(param1:int) : void
      {
         this._grenadesTF.text = param1.toString();
      }
      
      public function set backpackGrenadeType(param1:String) : void
      {
         if(this._grenadeIconLoader.source != param1)
         {
            this._grenadeIconLoader.source = param1;
         }
      }
      
      public function set firemodeIcon(param1:String) : void
      {
         if(param1 != "")
         {
            this.firemodeLoader.source = param1;
         }
      }
      
      public function setFlashlightBattery(param1:int, param2:Boolean) : void
      {
         this._flashlightBatteryMC.gotoAndStop(param1);
         if(param2)
         {
            this._flashlightIconMC.gotoAndStop("on");
         }
         else
         {
            this._flashlightIconMC.gotoAndStop("off");
         }
      }
      
      public function testBackpack(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.A)
         {
            this.backpackDosh = 100;
         }
         if(param1.keyCode == Keyboard.S)
         {
            this.backpackDosh = -100;
         }
      }
   }
}
