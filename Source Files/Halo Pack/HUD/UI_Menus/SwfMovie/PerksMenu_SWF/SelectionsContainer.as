package
{
   import tripwire.containers.Perks.PerkSelectionContainer;
   
   public dynamic class SelectionsContainer extends PerkSelectionContainer
   {
       
      
      public function SelectionsContainer()
      {
         super();
         this.__setProp_perkScrollingList_SelectionsContainer_perksList_0();
      }
      
      function __setProp_perkScrollingList_SelectionsContainer_perksList_0() : *
      {
         try
         {
            perkScrollingList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         perkScrollingList.enabled = true;
         perkScrollingList.enableInitCallback = false;
         perkScrollingList.focusable = true;
         perkScrollingList.itemRendererName = "";
         perkScrollingList.itemRendererInstanceName = "perk";
         perkScrollingList.margin = 0;
         perkScrollingList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         perkScrollingList.rowHeight = 72.4;
         perkScrollingList.scrollBar = "scrollBar";
         perkScrollingList.visible = true;
         perkScrollingList.wrapping = "normal";
         try
         {
            perkScrollingList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
