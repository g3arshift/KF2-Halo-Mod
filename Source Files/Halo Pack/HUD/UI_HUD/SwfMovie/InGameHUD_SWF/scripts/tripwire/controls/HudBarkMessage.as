package tripwire.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.events.Event;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   
   public class HudBarkMessage extends UIComponent
   {
       
      
      public var ANIM_TIME_0:int = 15;
      
      public var ANIM_TIME_1:int = 8;
      
      public var ANIM_DELAY:int = 82;
      
      public var textField:TextField;
      
      public function HudBarkMessage()
      {
         super();
      }
      
      public function set text(param1:Object) : void
      {
         var _loc2_:Number = 16777215;
         this.textField.text = !!param1.text?param1.text:"";
         if(param1.textColor != undefined && param1.textColor != "")
         {
            _loc2_ = uint("0x" + param1.textColor);
            this.textField.textColor = _loc2_;
         }
         this.openAnimation();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function openAnimation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = x - 24;
         var _loc3_:int = x - 32;
         TweenMax.fromTo(this,this.ANIM_TIME_1,{"alpha":0},{
            "alpha":1,
            "ease":Cubic.easeOut,
            "useFrames":true
         });
         TweenMax.fromTo(this,this.ANIM_TIME_0,{"x":this.x},{
            "x":_loc2_,
            "ease":Cubic.easeOut,
            "useFrames":true
         });
         TweenMax.fromTo(this,this.ANIM_TIME_1,{"alpha":1},{
            "alpha":0,
            "delay":this.ANIM_DELAY,
            "ease":Cubic.easeOut,
            "useFrames":true,
            "onComplete":this.onTweenComplete
         });
      }
      
      public function onTweenComplete() : void
      {
         dispatchEvent(new Event("onTweenComplete"));
      }
   }
}
