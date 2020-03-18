package
{
   import tripwire.controls.TripSlider;
   
   public dynamic class $Slider extends TripSlider
   {
       
      
      public function $Slider()
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
