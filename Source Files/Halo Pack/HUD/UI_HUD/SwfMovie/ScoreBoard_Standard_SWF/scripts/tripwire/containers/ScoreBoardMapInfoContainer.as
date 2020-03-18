package tripwire.containers
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import tripwire.Tools.TextfieldUtil;
   
   public class ScoreBoardMapInfoContainer extends UIComponent
   {
       
      
      public var mapText:TextField;
      
      public var matchInfoText:TextField;
      
      public var timeText:TextField;
      
      public var waveText:TextField;
      
      public var waveNumberText:TextField;
      
      public function ScoreBoardMapInfoContainer()
      {
         super();
         enableInitCallback = true;
      }
      
      public function set localizeText(param1:Object) : void
      {
         this.mapText.text = !!param1.mapText?param1.mapText:"";
         this.waveText.text = !!param1.waveText?param1.waveText:"";
         this.matchInfoText.text = !!param1.matchInfo?param1.matchInfo:"";
      }
      
      public function set waveNumber(param1:String) : void
      {
         this.waveNumberText.text = param1;
      }
      
      public function set timeValue(param1:int) : void
      {
         this.timeText.text = TextfieldUtil.instance.getFormattedTimeFromSeconds(param1);
      }
   }
}
