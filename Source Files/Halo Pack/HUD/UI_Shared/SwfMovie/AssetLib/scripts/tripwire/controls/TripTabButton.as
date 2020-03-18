package tripwire.controls
{
   import scaleform.clik.controls.Button;
   import scaleform.gfx.Extensions;
   import flash.events.MouseEvent;
   
   public class TripTabButton extends Button
   {
       
      
      public var tabClickSoundEffect = "SHARED_BUTTON_CLICK";
      
      public var tabOverSoundEffect = "SHARED_BUTTON_MOUSEOVER";
      
      public function TripTabButton()
      {
         super();
      }
      
      override protected function handlePress(param1:uint = 0) : void
      {
         if(!selected)
         {
            super.handlePress(param1);
            if(Extensions.gfxProcessSound != null && enabled == true)
            {
               Extensions.gfxProcessSound(this,"UI",this.tabClickSoundEffect);
            }
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(!selected)
         {
            super.handleMousePress(param1);
            if(Extensions.gfxProcessSound != null && enabled == true)
            {
               Extensions.gfxProcessSound(this,"UI",this.tabClickSoundEffect);
            }
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(!selected)
         {
            super.handleMouseRollOver(param1);
            if(Extensions.gfxProcessSound != null && enabled == true && selected == false)
            {
               Extensions.gfxProcessSound(this,"UI",this.tabOverSoundEffect);
            }
         }
      }
   }
}
