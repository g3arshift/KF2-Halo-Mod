package tripwire.controls.scoreboard
{
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.DataProvider;
   
   public class ScoreboardScrollingList extends ScrollingList
   {
       
      
      public function ScoreboardScrollingList()
      {
         super();
         focusable = false;
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function updatePlayerData(param1:Array) : *
      {
         dataProvider = new DataProvider(param1);
      }
   }
}
