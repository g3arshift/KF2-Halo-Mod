package
{
   import tripwire.widgets.TraderCompassWidget;
   
   public dynamic class CompassContainerMC extends TraderCompassWidget
   {
       
      
      public function CompassContainerMC()
      {
         super();
         this.__setProp_CompassPingAnimContainer_CompassContainerMC_Layer15_0();
      }
      
      function __setProp_CompassPingAnimContainer_CompassContainerMC_Layer15_0() : *
      {
         try
         {
            CompassPingAnimContainer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         CompassPingAnimContainer.enabled = true;
         CompassPingAnimContainer.enableInitCallback = true;
         CompassPingAnimContainer.visible = true;
         try
         {
            CompassPingAnimContainer["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
