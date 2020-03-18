package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.events.Event;
   import fl.motion.Color;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class BossHealthBarWidget extends UIComponent
   {
       
      
      public var bossnameText:TextField;
      
      public var healthBarShield:MovieClip;
      
      public var healthBarRed:MovieClip;
      
      public var healthBarGlow:MovieClip;
      
      protected var originalHealthBarWidth:Number;
      
      protected var previousHealthValue:Number = 1;
      
      protected var previousShieldValue:Number = 1;
      
      public const barOffset:int = 56;
      
      public function BossHealthBarWidget()
      {
         super();
         enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.originalHealthBarWidth = this.healthBarRed.width;
         this.healthBarGlow.width = 0;
         visible = false;
         this.currentShieldPercecntValue = 0;
      }
      
      public function onGlowComplete(param1:Event = null) : void
      {
         this.healthBarGlow.width = 0;
      }
      
      public function set currentBattlePhaseColor(param1:uint) : void
      {
         var _loc2_:Color = new Color();
         _loc2_.setTint(param1,1);
         this.healthBarRed.transform.colorTransform = _loc2_;
      }
      
      public function set currentShieldPercecntValue(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(this.previousShieldValue != param1)
         {
            _loc2_ = this.originalHealthBarWidth * param1;
            TweenMax.to(this.healthBarShield,4,{
               "width":_loc2_,
               "useFrames":true,
               "easing":Cubic.easeOut
            });
            if(this.healthBarShield.width > this.originalHealthBarWidth)
            {
               this.healthBarShield.width = this.originalHealthBarWidth;
            }
            this.previousShieldValue = param1;
         }
      }
      
      public function get currentShieldPercecntValue() : Number
      {
         return this.previousShieldValue;
      }
      
      public function set currentHealthPercentValue(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 > 1)
         {
            param1 = 1;
            visible = true;
         }
         if(param1 < 0)
         {
            param1 = 0;
            visible = false;
         }
         if(this.previousHealthValue != param1)
         {
            _loc2_ = this.healthBarRed.width;
            _loc3_ = this.originalHealthBarWidth * param1;
            this.healthBarGlow.x = _loc2_ + this.barOffset;
            TweenMax.to(this.healthBarRed,4,{
               "width":_loc3_,
               "useFrames":true,
               "easing":Cubic.easeOut
            });
            if(this.healthBarRed.width > this.originalHealthBarWidth)
            {
               this.healthBarRed.width = this.originalHealthBarWidth;
               this.healthBarGlow.x = this.originalHealthBarWidth + this.barOffset;
            }
            TweenMax.killTweensOf(this.healthBarGlow);
            if(_loc2_ > _loc3_)
            {
               this.healthBarGlow.alpha = 1;
               TweenMax.to(this.healthBarGlow,4,{
                  "x":_loc3_ + this.barOffset,
                  "width":this.healthBarGlow.width + (_loc2_ - _loc3_),
                  "useFrames":true,
                  "easing":Cubic.easeOut
               });
               TweenMax.to(this.healthBarGlow,4,{
                  "delay":8,
                  "alpha":0,
                  "useFrames":true,
                  "easing":Cubic.easeOut
               });
               TweenMax.to(this.healthBarGlow,4,{
                  "delay":12,
                  "alpha":1,
                  "useFrames":true,
                  "repeat":3,
                  "yoyo":true,
                  "easing":Cubic.easeOut,
                  "onComplete":this.onGlowComplete
               });
            }
            if(_loc2_ < _loc3_ && this.healthBarGlow.width != 0)
            {
               TweenMax.to(this.healthBarGlow,2,{
                  "alpha":0,
                  "useFrames":true,
                  "easing":Cubic.easeOut,
                  "onComplete":this.onGlowComplete
               });
            }
            this.previousHealthValue = param1;
         }
      }
      
      public function get currentHealthPercentValue() : Number
      {
         return this.previousHealthValue;
      }
      
      public function onKeyPress(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.A:
               this.currentShieldPercecntValue = this.currentShieldPercecntValue + 0.1;
               break;
            case Keyboard.B:
               this.currentShieldPercecntValue = this.currentShieldPercecntValue - 0.1;
         }
      }
   }
}
