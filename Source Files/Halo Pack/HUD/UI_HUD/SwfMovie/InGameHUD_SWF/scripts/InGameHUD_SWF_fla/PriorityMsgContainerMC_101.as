package InGameHUD_SWF_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class PriorityMsgContainerMC_101 extends MovieClip
   {
       
      
      public var PriorityMsgBG:MovieClip;
      
      public var PriorityMsgInfoContainer:MovieClip;
      
      public var PriorityMsgLeftBumper:MovieClip;
      
      public var PriorityMsgRightBumper:MovieClip;
      
      public function PriorityMsgContainerMC_101()
      {
         super();
         addFrameScript(0,this.frame1,33,this.frame34,43,this.frame44);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame34() : *
      {
         stop();
      }
      
      function frame44() : *
      {
         dispatchEvent(new Event("onPriorityMessageFadeOutComplete"));
         stop();
      }
   }
}
