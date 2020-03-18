package tripwire.widgets
{
   import tripwire.containers.TripContainer;
   import flash.utils.Timer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   
   public class NonCriticalGameMessageWidget extends TripContainer
   {
       
      
      public const messageDisplayTime:int = 2000;
      
      public const messageBuffer:int = 32;
      
      public var messageDisplayTimer:Timer;
      
      public var msgText:TextField;
      
      public var scanlinesMC:MovieClip;
      
      public var bgMC:MovieClip;
      
      public function NonCriticalGameMessageWidget()
      {
         super();
         enableInitCallback = true;
         visible = false;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function set message(param1:String) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.messageDisplayTimer != null)
         {
            this.messageDisplayTimer.stop();
         }
         if(param1 == "")
         {
            closeContainer();
            return;
         }
         this.messageDisplayTimer = new Timer(this.messageDisplayTime,1);
         this.messageDisplayTimer.addEventListener(TimerEvent.TIMER,this.onTimerComplete,false,0,true);
         this.messageDisplayTimer.start();
         openContainer();
         this.msgText.text = param1;
         _loc2_ = this.msgText.textWidth + this.messageBuffer;
         this.bgMC.width = _loc2_;
         if(this.scanlinesMC)
         {
            this.scanlinesMC.width = _loc2_;
         }
         this.bgMC.x = (this.msgText.width - this.bgMC.width) / 2;
         if(this.scanlinesMC)
         {
            this.scanlinesMC.x = (this.msgText.width - this.scanlinesMC.width) / 2;
         }
      }
      
      function onTimerComplete(param1:TimerEvent) : void
      {
         closeContainer();
      }
      
      override protected function openAnimation(param1:Boolean = true) : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,4,{
            "alpha":0,
            "ease":Linear.easeNone,
            "useFrames":true
         },{
            "alpha":_defaultAlpha,
            "ease":Linear.easeNone,
            "delay":ANIM_TIME,
            "useFrames":true,
            "onComplete":onOpened
         });
      }
      
      override protected function closeAnimation() : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,4,{
            "alpha":_defaultAlpha,
            "ease":Linear.easeNone,
            "useFrames":true
         },{
            "alpha":0,
            "ease":Linear.easeNone,
            "useFrames":true,
            "onComplete":onClosed
         });
      }
   }
}
