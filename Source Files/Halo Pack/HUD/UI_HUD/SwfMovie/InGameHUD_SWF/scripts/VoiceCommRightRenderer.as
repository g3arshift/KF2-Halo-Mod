package
{
   import tripwire.controls.voiceComms.VoiceCommsOptionRenderer;
   
   public dynamic class VoiceCommRightRenderer extends VoiceCommsOptionRenderer
   {
       
      
      public function VoiceCommRightRenderer()
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
