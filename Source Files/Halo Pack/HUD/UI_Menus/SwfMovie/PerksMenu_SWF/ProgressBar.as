package
{
   import flash.display.MovieClip;
   
   public dynamic class ProgressBar extends MovieClip
   {
       
      
      public function ProgressBar()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
