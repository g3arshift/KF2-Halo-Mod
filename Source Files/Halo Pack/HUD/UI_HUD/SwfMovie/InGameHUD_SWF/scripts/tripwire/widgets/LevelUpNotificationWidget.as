package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class LevelUpNotificationWidget extends UIComponent
   {
       
      
      public var iconLoaderContainer:MovieClip;
      
      public var perkNameTextMC:MovieClip;
      
      public var currentLevelTextMC:MovieClip;
      
      public var previousLevelTextMC:MovieClip;
      
      public var levelUpTextMC:MovieClip;
      
      public var tierUnlockTextMC:MovieClip;
      
      private var showTimer:Timer;
      
      private const levelUpShowTime:Number = 3000;
      
      public function LevelUpNotificationWidget()
      {
         super();
         enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function set localizeText(param1:Object) : void
      {
         this.levelUpTextMC.levelUpText.text = !!param1.levelUpString?param1.levelUpString:"";
         this.tierUnlockTextMC.levelUpText.text = !!param1.tierUnlockedString?param1.tierUnlockedString:"";
      }
      
      public function showLevelUp(param1:String, param2:int, param3:String, param4:Boolean) : void
      {
         this.perkNameTextMC.perkNameText.text = param1;
         this.previousLevelTextMC.levelText.text = param2 - 1;
         this.currentLevelTextMC.levelText.text = param2;
         if(param3 != null && param3 != "")
         {
            this.iconLoaderContainer.iconLoader.source = param3;
         }
         this.tierUnlockTextMC.visible = param4;
         gotoAndPlay("Play");
         visible = true;
         this.showTimer = new Timer(this.levelUpShowTime,1);
         this.showTimer.addEventListener(TimerEvent.TIMER,this.onShowTimerComplete,false,0,true);
         this.showTimer.start();
      }
      
      private function onShowTimerComplete(param1:TimerEvent) : void
      {
         gotoAndPlay("Close");
      }
   }
}
