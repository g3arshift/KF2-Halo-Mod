package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Cubic;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class PriorityMsgWidget extends UIComponent
   {
       
      
      private var _priorityMessagePrimaryTF:TextField = null;
      
      private var _priorityMessageSecondaryTF:TextField = null;
      
      private var _msgFadeTimer;
      
      public var PriorityMsgContainer:MovieClip;
      
      public var PriorityMsgInfoContainer:MovieClip;
      
      public function PriorityMsgWidget()
      {
         this._msgFadeTimer = new Timer(1000,1);
         super();
         _enableInitCallback = true;
         this.cachePriorityMsgWidgetChildren();
         this._msgFadeTimer.addEventListener(TimerEvent.TIMER,this.onPriorityMessageFinished);
         visible = false;
      }
      
      private function cachePriorityMsgWidgetChildren() : *
      {
         this._priorityMessagePrimaryTF = this.PriorityMsgContainer.PriorityMsgInfoContainer.PriorityMsgTextContainer.PriorityMsgTextPrimary;
         this._priorityMessageSecondaryTF = this.PriorityMsgContainer.PriorityMsgInfoContainer.PriorityMsgSubTextContainer.PriorityMsgTextSecondary;
         this._priorityMessageSecondaryTF.text = "";
         this._priorityMessagePrimaryTF.text = "";
         this.PriorityMsgContainer.addEventListener("onPriorityMessageFadeOutComplete",this.onPriorityMessageFadeOutComplete);
      }
      
      public function showNewPriorityMessage(param1:String, param2:String, param3:int) : void
      {
         visible = true;
         this.PriorityMsgContainer.gotoAndStop("In");
         this.PriorityMsgContainer.PriorityMsgInfoContainer.gotoAndStop("Main");
         if(param1 != "")
         {
            this._priorityMessagePrimaryTF.text = param1;
         }
         if(param2 != "")
         {
            this.PriorityMsgContainer.PriorityMsgInfoContainer.gotoAndStop("Sub");
            this._priorityMessageSecondaryTF.text = param2;
            TweenMax.to(this.PriorityMsgContainer.PriorityMsgInfoContainer,1,{
               "frame":2,
               "delay":60,
               "useFrames":true
            });
            TweenMax.to(this.PriorityMsgContainer.PriorityMsgInfoContainer,10,{
               "frame":24,
               "delay":64,
               "useFrames":true,
               "ease":Linear.easeNone
            });
         }
         this.PriorityMsgContainer.gotoAndPlay("In");
         TweenMax.fromTo(this.PriorityMsgContainer,4,{
            "alpha":0,
            "z":128
         },{
            "alpha":1,
            "z":0,
            "useFrames":true,
            "ease":Cubic.easeOut
         });
         if(param3 > 0)
         {
            this._msgFadeTimer.delay = param3 * 1000;
            this._msgFadeTimer.reset();
            this._msgFadeTimer.start();
         }
      }
      
      private function onPriorityMessageFinished(param1:TimerEvent) : *
      {
         this.PriorityMsgContainer.gotoAndStop("Out");
         TweenMax.fromTo(this.PriorityMsgContainer,8,{
            "alpha":1,
            "z":0
         },{
            "alpha":0,
            "z":128,
            "delay":24,
            "useFrames":true,
            "ease":Cubic.easeOut
         });
      }
      
      private function onPriorityMessageFadeOutComplete(param1:Event) : *
      {
         visible = false;
         this._priorityMessageSecondaryTF.text = "";
         this._priorityMessagePrimaryTF.text = "";
      }
   }
}
