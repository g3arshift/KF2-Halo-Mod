package
{
   import tripwire.controls.PlayerChatScrollingList;
   
   public dynamic class DefaultScrollingList extends PlayerChatScrollingList
   {
       
      
      public function DefaultScrollingList()
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
