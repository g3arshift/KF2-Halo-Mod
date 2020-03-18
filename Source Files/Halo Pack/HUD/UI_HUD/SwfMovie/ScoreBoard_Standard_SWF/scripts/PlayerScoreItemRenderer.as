package
{
   import tripwire.controls.scoreboard.ScoreboardLineRenderer;
   
   public dynamic class PlayerScoreItemRenderer extends ScoreboardLineRenderer
   {
       
      
      public function PlayerScoreItemRenderer()
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
