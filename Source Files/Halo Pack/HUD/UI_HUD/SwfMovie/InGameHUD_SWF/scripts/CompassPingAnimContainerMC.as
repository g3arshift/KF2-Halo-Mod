package
{
   import scaleform.clik.core.UIComponent;
   
   public dynamic class CompassPingAnimContainerMC extends UIComponent
   {
       
      
      public function CompassPingAnimContainerMC()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
