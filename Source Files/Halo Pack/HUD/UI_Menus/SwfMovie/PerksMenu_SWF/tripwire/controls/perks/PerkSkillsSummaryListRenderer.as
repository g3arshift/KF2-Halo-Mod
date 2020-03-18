package tripwire.controls.perks
{
   import flash.text.TextFormat;
   import scaleform.gfx.TextFieldEx;
   
   public class PerkSkillsSummaryListRenderer extends PerkSkillsListRenderer
   {
       
      
      public var skillNameFormat:TextFormat;
      
      public var skillNameOriginalSize:int;
      
      private const skillNameAltSize:int = 17;
      
      public function PerkSkillsSummaryListRenderer()
      {
         this.skillNameFormat = new TextFormat();
         bShrinkText = false;
         super();
         mouseEnabled = false;
         highlightColor = 14538703;
         this.skillNameFormat = textField.defaultTextFormat;
         this.skillNameOriginalSize = int(this.skillNameFormat.size);
         TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(textField.textHeight > textField.height)
         {
            this.skillNameFormat.size = this.skillNameAltSize;
            textField.setTextFormat(this.skillNameFormat);
         }
      }
   }
}
