package
{
   public dynamic class BaseButton extends tripwire.controls.BaseButton
   {
       
      
      public function BaseButton()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
      
      function frame4() : *
      {
         stop();
      }
      
      function frame5() : *
      {
         stop();
      }
   }
}
