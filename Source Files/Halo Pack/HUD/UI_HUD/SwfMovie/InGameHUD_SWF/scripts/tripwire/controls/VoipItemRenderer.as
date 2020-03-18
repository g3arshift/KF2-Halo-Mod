package tripwire.controls
{
   import flash.display.MovieClip;
   
   public class VoipItemRenderer extends TripListItemRenderer
   {
       
      
      private const BG_OFFSET:int = 56;
      
      private const TEXT_OFFSET:int = 24;
      
      private const PS4_CHAR_LIMIT:int = 16;
      
      public var scanlines:MovieClip;
      
      public var voipBG:MovieClip;
      
      public function VoipItemRenderer()
      {
         preventAutosizing = true;
         super();
      }
      
      override protected function updateText() : void
      {
         if(_label != null && textField != null)
         {
            textField.text = _label;
            if(textField.textWidth > textField.width && textField.length > this.PS4_CHAR_LIMIT)
            {
               textField.text = textField.text.slice(0,textField.getCharIndexAtPoint(textField.width - this.TEXT_OFFSET,textField.height / 2)) + "...";
            }
            this.scanlines.width = this.voipBG.width = textField.textWidth + this.BG_OFFSET;
         }
      }
   }
}
