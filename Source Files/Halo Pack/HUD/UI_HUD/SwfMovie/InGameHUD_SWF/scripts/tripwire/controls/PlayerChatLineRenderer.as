package tripwire.controls
{
   import scaleform.clik.controls.ListItemRenderer;
   import com.greensock.TweenMax;
   import flash.utils.Timer;
   import flash.text.TextFormat;
   import flash.events.TimerEvent;
   
   public class PlayerChatLineRenderer extends ListItemRenderer
   {
      
      public static const ITEM_LIFETIME:Number = 5000;
       
      
      public var bHistoryIsOpen:Boolean;
      
      public var bMessageExpired:Boolean = true;
      
      public var bPendingExpiration:Boolean;
      
      public var messageString:String;
      
      public var lifeTime:int;
      
      public var alphaTween:TweenMax;
      
      public var currentColor:Number = 16777215;
      
      public var timeStamp:Number = -1;
      
      private var _msgFadeTimer:Timer;
      
      public function PlayerChatLineRenderer()
      {
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20,29,this.frame30,39,this.frame40,40,this.frame41,49,this.frame50,59,this.frame60,69,this.frame70,79,this.frame80);
         super();
         this.startExpiring();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:* = new TextFormat();
         _loc2_ = textField.getTextFormat();
         this.data = param1;
         _loc2_.color = !!param1?param1.messageClr:16777215;
         textField.defaultTextFormat = _loc2_;
         textField.text = !!param1?param1.label:"";
         this.timeStamp = !!param1?Number(param1.timeStamp):Number(-1);
         this.compareTimeStamp();
      }
      
      private function compareTimeStamp() : *
      {
         var _loc1_:Date = new Date();
         if(this.timeStamp < 0)
         {
            this.bMessageExpired = true;
            this.bPendingExpiration = false;
            return;
         }
         this.lifeTime = ITEM_LIFETIME - (_loc1_.getTime() - this.timeStamp);
         if(this.lifeTime > ITEM_LIFETIME)
         {
            this.lifeTime = ITEM_LIFETIME;
         }
         if(this._msgFadeTimer != null)
         {
            this._msgFadeTimer.stop();
            this._msgFadeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFadeoutComplete);
            this._msgFadeTimer = null;
         }
         if(label != "")
         {
            this.startExpiring();
         }
      }
      
      public function setColor(param1:Number) : *
      {
         var _loc2_:* = new TextFormat();
         _loc2_ = textField.getTextFormat();
         _loc2_.color = !!data?data.messageClr:16777215;
         textField.defaultTextFormat = _loc2_;
      }
      
      public function startExpiring() : void
      {
         if(this.lifeTime > 0)
         {
            this.bPendingExpiration = true;
            this.bMessageExpired = false;
            if(this._msgFadeTimer == null)
            {
               this._msgFadeTimer = new Timer(this.lifeTime,1);
            }
            else
            {
               this._msgFadeTimer.reset();
            }
            this._msgFadeTimer.addEventListener(TimerEvent.TIMER,this.onFadeoutComplete,false,0,true);
            this._msgFadeTimer.start();
            this.setShowChatLine(true);
         }
         else
         {
            this.bPendingExpiration = false;
            this.bMessageExpired = true;
            if(!this.bHistoryIsOpen)
            {
               this.alphaTween = new TweenMax(this,100,{
                  "alpha":0,
                  "useFrames":true
               });
            }
         }
      }
      
      private function onFadeoutComplete(param1:TimerEvent) : *
      {
         this.bPendingExpiration = false;
         this.bMessageExpired = true;
         this.lifeTime = 0;
         if(!this.bHistoryIsOpen)
         {
            this.setShowChatLine(false);
         }
      }
      
      public function onChatWindowToggle(param1:Boolean) : *
      {
         if(param1)
         {
            this.setShowChatLine(true);
         }
         else if(this.bMessageExpired)
         {
            this.setShowChatLine(false);
         }
         else
         {
            this.setShowChatLine(true);
         }
      }
      
      public function setShowChatLine(param1:Boolean) : *
      {
         if(!param1)
         {
            TweenMax.killTweensOf(this);
            this.alphaTween = new TweenMax(this,100,{
               "alpha":0,
               "useFrames":true
            });
         }
         else
         {
            visible = true;
            TweenMax.killTweensOf(this);
            alpha = 1;
         }
      }
      
      function frame1() : *
      {
      }
      
      function frame10() : *
      {
         stop();
      }
      
      function frame20() : *
      {
         stop();
      }
      
      function frame30() : *
      {
         stop();
      }
      
      function frame40() : *
      {
         stop();
      }
      
      function frame41() : *
      {
      }
      
      function frame50() : *
      {
         stop();
      }
      
      function frame60() : *
      {
         stop();
      }
      
      function frame70() : *
      {
         stop();
      }
      
      function frame80() : *
      {
         stop();
      }
   }
}
