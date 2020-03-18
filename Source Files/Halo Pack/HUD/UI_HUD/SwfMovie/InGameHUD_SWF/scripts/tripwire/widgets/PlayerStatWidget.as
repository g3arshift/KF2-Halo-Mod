package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.clik.controls.UILoader;
   import tripwire.containers.ValueBarkContainer;
   import scaleform.clik.controls.TileList;
   import scaleform.clik.data.DataProvider;
   import tripwire.Tools.TextfieldUtil;
   import com.greensock.TweenMax;
   import flash.events.Event;
   
   public class PlayerStatWidget extends UIComponent
   {
       
      
      public var characterNameTextfield:TextField;
      
      protected var _healthTextTF:TextField;
      
      protected var _armorTextTF:TextField;
      
      protected var _xpBar:MovieClip;
      
      protected var _xpBarHighlight:MovieClip;
      
      protected var _perkLevelTextTF:TextField;
      
      protected var _perkIconLoader:UILoader;
      
      protected var _healerChargeBarMC:MovieClip;
      
      public var HealthArmorContainer:MovieClip;
      
      public var PerkXPContainer:MovieClip;
      
      public var HealerContainer:MovieClip;
      
      public var XPBarkMC:ValueBarkContainer;
      
      public var IndicatorTileList:TileList;
      
      private var xpBarHeight:Number;
      
      public var expString:String;
      
      public var currentXPPercent:int;
      
      public var bLevelUp:Boolean = false;
      
      public var bXPInit:Boolean = false;
      
      private var whiteColor:uint = 16777215;
      
      private var highlightColor:uint = 16744742;
      
      public function PlayerStatWidget()
      {
         super();
         _enableInitCallback = true;
         this.cachePlayerStatWidgets();
         this.init();
      }
      
      public function init() : *
      {
         this.PerkXPContainer.xpBarHighlight.alpha = 0;
         this.xpBarHeight = this.PerkXPContainer.xpBarHighlight.height;
      }
      
      public function set characterName(param1:String) : void
      {
         if(this.characterNameTextfield)
         {
            this.characterNameTextfield.text = param1;
         }
      }
      
      public function cachePlayerStatWidgets() : *
      {
         this._healthTextTF = this.HealthArmorContainer.HealthContainer.HealthTextField;
         this._armorTextTF = this.HealthArmorContainer.ArmorContainer.ArmorTextField;
         this._perkIconLoader = this.PerkXPContainer.PerkLevelContainer.PerkIconLoader;
         this._perkLevelTextTF = this.PerkXPContainer.PerkLevelContainer.PerkLevelTextField;
         this._healerChargeBarMC = this.HealerContainer.HealerBarContainer;
         this._xpBarHighlight = this.PerkXPContainer.xpBarHighlight;
         this._xpBar = this.PerkXPContainer.xpBar;
      }
      
      public function set activeEffects(param1:Array) : *
      {
         this.IndicatorTileList.dataProvider = new DataProvider(param1);
         this.IndicatorTileList.invalidate();
      }
      
      public function set playerHealth(param1:int) : void
      {
         this._healthTextTF.text = param1.toString();
         TextfieldUtil.instance.InvalidateFilteredDisplayObject(this._healthTextTF);
      }
      
      public function set playerArmor(param1:int) : void
      {
         this._armorTextTF.text = param1.toString();
         TextfieldUtil.instance.InvalidateFilteredDisplayObject(this._armorTextTF);
      }
      
      public function set playerPerkXPPercent(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 100)
         {
            param1 = 100;
         }
         this.currentXPPercent = param1;
         if(this.bLevelUp)
         {
            this._xpBarHighlight.gotoAndStop(100 + 1);
         }
         else
         {
            this._xpBarHighlight.gotoAndStop(param1 + 1);
         }
         if(!this.bXPInit)
         {
            this._xpBar.gotoAndStop(this.currentXPPercent + 1);
            this.bXPInit = true;
         }
      }
      
      public function showXPBark(param1:int, param2:String, param3:Boolean) : void
      {
         TweenMax.killTweensOf(this._xpBarHighlight);
         this._xpBarHighlight.alpha = 0;
         if(param3)
         {
            TweenMax.to(this._xpBarHighlight,10,{
               "alpha":1,
               "useFrames":true,
               "repeat":3,
               "yoyo":true,
               "onComplete":this.barkComplete
            });
         }
         this.XPBarkMC.playBark(param1,this.expString,param2);
      }
      
      public function barkComplete(param1:Event = null) : void
      {
         this._xpBar.gotoAndStop(this.currentXPPercent + 1);
      }
      
      public function set playerPerkLevel(param1:int) : void
      {
         this._perkLevelTextTF.text = param1.toString();
      }
      
      public function set playerPerkIcon(param1:String) : void
      {
         if(param1 != null && param1 != "")
         {
            this._perkIconLoader.source = param1;
         }
      }
      
      public function set playerHealerCharge(param1:int) : void
      {
         if(param1 < 100)
         {
            this._healerChargeBarMC.gotoAndStop(param1 + 1);
         }
         else if(param1 == 100)
         {
            this._healerChargeBarMC.gotoAndPlay(param1 + 1);
         }
      }
   }
}
