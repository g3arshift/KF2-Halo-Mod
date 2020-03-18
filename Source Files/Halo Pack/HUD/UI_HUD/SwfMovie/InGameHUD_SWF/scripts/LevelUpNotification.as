package
{
   import tripwire.widgets.LevelUpNotificationWidget;
   import flash.events.Event;
   
   public dynamic class LevelUpNotification extends LevelUpNotificationWidget
   {
       
      
      public function LevelUpNotification()
      {
         super();
         addFrameScript(0,this.frame1,56,this.frame57,67,this.frame68);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame57() : *
      {
         stop();
      }
      
      function frame68() : *
      {
         stop();
         dispatchEvent(new Event("LevelUpDone",true,true));
      }
   }
}
