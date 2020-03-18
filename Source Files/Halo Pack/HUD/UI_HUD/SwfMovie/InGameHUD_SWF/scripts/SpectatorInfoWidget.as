package
{
   public dynamic class SpectatorInfoWidget extends tripwire.widgets.SpectatorInfoWidget
   {
       
      
      public function SpectatorInfoWidget()
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
