package
{
   import scaleform.clik.controls.Button;
   
   public dynamic class s_ScrollBar_track extends Button
   {
       
      
      public function s_ScrollBar_track()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20,29,this.frame30,39,this.frame40);
      }
      
      function frame1() : *
      {
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
      
      function frame40() : *
      {
         stop();
      }
   }
}
