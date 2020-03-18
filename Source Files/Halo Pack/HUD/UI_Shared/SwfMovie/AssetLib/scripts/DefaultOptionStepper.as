package
{
   import tripwire.controls.TripOptionStepper;
   
   public dynamic class DefaultOptionStepper extends TripOptionStepper
   {
       
      
      public function DefaultOptionStepper()
      {
         super();
         addFrameScript(9,this.frame10,19,this.frame20,29,this.frame30);
      }
      
      function frame10() : *
      {
         stop();
      }
      
      function frame20() : *
      {
         stop();
      }
      
      function frame30() : *
      {
         stop();
      }
   }
}
