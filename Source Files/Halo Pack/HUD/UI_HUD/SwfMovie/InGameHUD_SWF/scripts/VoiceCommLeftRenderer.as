package
{
   import tripwire.controls.voiceComms.VoiceCommsOptionRenderer;
   
   public dynamic class VoiceCommLeftRenderer extends VoiceCommsOptionRenderer
   {
       
      
      public function VoiceCommLeftRenderer()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
   }
}
