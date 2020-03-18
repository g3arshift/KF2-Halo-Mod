package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.events.Event;
   import tripwire.Tools.TextfieldUtil;
   
   public class WaveInfoWidget extends UIComponent
   {
       
      
      private var _currentWaveNum:int = 0;
      
      private var _maxWaveNum:int = 0;
      
      public var ZedCountInfoContainer:MovieClip;
      
      public var WaveCountInfoContainer:MovieClip;
      
      public var bossWaveString:String = " ---";
      
      public var finalWaveString:String;
      
      public var ZEDTextformat:TextFormat;
      
      public function WaveInfoWidget()
      {
         this.ZEDTextformat = new TextFormat();
         super();
         _enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.remainingZEDs = -1;
      }
      
      public function set bossText(param1:String) : void
      {
         this.bossWaveString = param1;
      }
      
      public function set finalText(param1:String) : void
      {
         this.finalWaveString = param1;
      }
      
      public function set waveText(param1:String) : void
      {
         this.WaveCountInfoContainer.WaveCountTitle.text = param1;
      }
      
      public function set remainingZEDs(param1:int) : void
      {
         if(param1 == -1)
         {
            this.ZedCountInfoContainer.ZedCount.text = this.bossWaveString;
         }
         else
         {
            this.ZedCountInfoContainer.ZedCount.text = Math.max(param1,0).toString();
         }
         if(this.ZedCountInfoContainer.ZedCountIcon.currentFrame != "ZedCountIcon")
         {
            this.ZedCountInfoContainer.ZedCountIcon.gotoAndStop("ZedCountIcon");
         }
         this.resizeZEDCountText();
      }
      
      public function set currentWave(param1:int) : void
      {
         this._currentWaveNum = param1;
         if(param1 > this._maxWaveNum)
         {
            this.WaveCountInfoContainer.WaveCount.text = this.finalWaveString;
         }
         else
         {
            this.WaveCountInfoContainer.WaveCount.text = this._currentWaveNum + "/" + this._maxWaveNum;
         }
      }
      
      public function set maxWaves(param1:int) : void
      {
         this._maxWaveNum = param1;
         this.WaveCountInfoContainer.WaveCount.text = this._currentWaveNum + "/" + this._maxWaveNum;
      }
      
      public function set remainingTraderTime(param1:int) : void
      {
         this.ZedCountInfoContainer.ZedCount.text = TextfieldUtil.instance.getFormattedTimeFromSeconds(Math.max(param1,0));
         if(this.ZedCountInfoContainer.ZedCountIcon.currentFrame != "TraderTimeIcon")
         {
            this.ZedCountInfoContainer.ZedCountIcon.gotoAndStop("TraderTimeIcon");
         }
         this.resizeZEDCountText();
      }
      
      private function resizeZEDCountText() : void
      {
      }
   }
}
