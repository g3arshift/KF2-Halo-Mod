package
{
   import tripwire.controls.scoreboard.ScoreboardScrollingList;
   
   public dynamic class DefaultScoreboardScrollingList extends ScoreboardScrollingList
   {
       
      
      public function DefaultScoreboardScrollingList()
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
