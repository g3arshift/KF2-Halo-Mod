package
{
   import tripwire.containers.ValueBarkContainer;
   import flash.events.Event;
   
   public dynamic class XPBarkAnimContainer extends ValueBarkContainer
   {
       
      
      public function XPBarkAnimContainer()
      {
         super();
         addFrameScript(0,this.frame1,40,this.frame41,63,this.frame64);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame41() : *
      {
         dispatchEvent(new Event("onBarkComplete"));
      }
      
      function frame64() : *
      {
         dispatchEvent(new Event("onBarkComplete"));
         stop();
      }
   }
}
