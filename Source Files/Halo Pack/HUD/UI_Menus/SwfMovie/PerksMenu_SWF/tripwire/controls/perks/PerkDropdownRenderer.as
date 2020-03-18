package tripwire.controls.perks
{
   public class PerkDropdownRenderer extends PerkSelectLineRenderer
   {
       
      
      public function PerkDropdownRenderer()
      {
         super();
      }
      
      override protected function highlightButton() : *
      {
         textField.textColor = highlightColor;
         if(perkLevelText != null)
         {
            perkLevelText.textColor = highlightColor;
         }
      }
      
      override protected function unhighlightButton() : *
      {
         textField.textColor = defaultColor;
         if(perkLevelText != null)
         {
            perkLevelText.textColor = defaultColor;
         }
      }
   }
}
