package tripwire.controls
{
   import flash.events.MouseEvent;
   import scaleform.gfx.Extensions;
   
   public class TripBackButton extends TripButton
   {
       
      
      public var backSoundEffect:String = "SHARED_BACK_BUTTON";
      
      public function TripBackButton()
      {
         super();
         doAnimations = true;
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         if(Extensions.gfxProcessSound != null && enabled == true)
         {
            Extensions.gfxProcessSound(this,"UI",this.backSoundEffect);
         }
      }
      
      override protected function handlePress(param1:uint = 0) : void
      {
         super.handlePress(param1);
         if(Extensions.gfxProcessSound != null && enabled == true)
         {
            Extensions.gfxProcessSound(this,"UI",this.backSoundEffect);
         }
      }
   }
}
