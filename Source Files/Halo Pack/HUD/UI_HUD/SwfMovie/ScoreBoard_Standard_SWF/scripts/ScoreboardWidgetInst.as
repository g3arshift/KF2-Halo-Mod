package
{
   import tripwire.widgets.ScoreboardWidget;
   
   public dynamic class ScoreboardWidgetInst extends ScoreboardWidget
   {
       
      
      public function ScoreboardWidgetInst()
      {
         super();
         this.__setProp_PlayerScrollingList_ScoreboardWidgetInst_PlayerList_0();
      }
      
      function __setProp_PlayerScrollingList_ScoreboardWidgetInst_PlayerList_0() : *
      {
         try
         {
            PlayerScrollingList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         PlayerScrollingList.enabled = true;
         PlayerScrollingList.enableInitCallback = false;
         PlayerScrollingList.focusable = false;
         PlayerScrollingList.itemRendererName = "";
         PlayerScrollingList.itemRendererInstanceName = "PlayerScore";
         PlayerScrollingList.margin = 10;
         PlayerScrollingList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         PlayerScrollingList.rowHeight = 0;
         PlayerScrollingList.scrollBar = "";
         PlayerScrollingList.visible = true;
         PlayerScrollingList.wrapping = "normal";
         try
         {
            PlayerScrollingList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
