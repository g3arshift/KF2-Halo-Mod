package
{
   import tripwire.widgets.PlayerStatWidget;
   
   public dynamic class PlayerStatWidgetMC extends PlayerStatWidget
   {
       
      
      public function PlayerStatWidgetMC()
      {
         super();
         addFrameScript(0,this.frame1);
         this.__setProp_IndicatorTileList_PlayerStatWidgetMC_ActiveIndicators_0();
      }
      
      function __setProp_IndicatorTileList_PlayerStatWidgetMC_ActiveIndicators_0() : *
      {
         try
         {
            IndicatorTileList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         IndicatorTileList.columnWidth = 0;
         IndicatorTileList.direction = "horizontal";
         IndicatorTileList.enabled = true;
         IndicatorTileList.enableInitCallback = false;
         IndicatorTileList.externalColumnCount = 0;
         IndicatorTileList.focusable = false;
         IndicatorTileList.itemRendererName = "";
         IndicatorTileList.itemRendererInstanceName = "indicator";
         IndicatorTileList.margin = 0;
         IndicatorTileList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         IndicatorTileList.rowHeight = 0;
         IndicatorTileList.scrollBar = "";
         IndicatorTileList.visible = true;
         IndicatorTileList.wrapping = "normal";
         try
         {
            IndicatorTileList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {
      }
   }
}
