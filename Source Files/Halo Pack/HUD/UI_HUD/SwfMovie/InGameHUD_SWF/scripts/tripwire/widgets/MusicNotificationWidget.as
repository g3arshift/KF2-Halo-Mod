package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.utils.Timer;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.events.TimerEvent;
   
   public class MusicNotificationWidget extends UIComponent
   {
       
      
      public var textHolder;
      
      public const NOTIFICATION_SHOW_TIME:int = 5000;
      
      public var closeTimer:Timer;
      
      public var splitString:Array;
      
      public var artistString:String;
      
      public var songString:String;
      
      public function MusicNotificationWidget()
      {
         super();
         enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      protected function OnButtonPress(param1:KeyboardEvent) : void
      {
         if(Keyboard.A == param1.keyCode)
         {
            this.text = "TEST SONG -- TEST HIPSTER BAND!";
         }
      }
      
      public function set text(param1:String) : void
      {
         this.splitString = param1.split(" -- ");
         this.artistString = this.splitString[1];
         this.songString = this.splitString[0];
         if(this.closeTimer)
         {
            this.closeTimer.reset();
            this.closeTimer = null;
         }
         gotoAndPlay("open");
         this.textHolder.artistText.text = this.artistString;
         this.textHolder.songText.text = this.songString;
         this.closeTimer = new Timer(this.NOTIFICATION_SHOW_TIME,1);
         this.closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerExpire,false,0,true);
         this.closeTimer.start();
      }
      
      public function onTimerExpire(param1:TimerEvent) : void
      {
         gotoAndPlay("close");
      }
   }
}
