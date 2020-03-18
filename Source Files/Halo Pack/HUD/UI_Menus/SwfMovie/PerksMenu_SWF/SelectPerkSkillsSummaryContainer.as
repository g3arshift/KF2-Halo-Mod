package
{
   import tripwire.containers.Perks.PerksSkillsSummaryContainer;
   
   public dynamic class SelectPerkSkillsSummaryContainer extends PerksSkillsSummaryContainer
   {
       
      
      public function SelectPerkSkillsSummaryContainer()
      {
         super();
         this.__setProp_skillList_SelectPerkSkillsSummaryContainer_ScrollingList_0();
      }
      
      function __setProp_skillList_SelectPerkSkillsSummaryContainer_ScrollingList_0() : *
      {
         try
         {
            skillList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         skillList.enabled = true;
         skillList.enableInitCallback = false;
         skillList.focusable = false;
         skillList.itemRendererName = "";
         skillList.itemRendererInstanceName = "tier";
         skillList.margin = 0;
         skillList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":20
         };
         skillList.rowHeight = 0;
         skillList.scrollBar = "";
         skillList.visible = true;
         skillList.wrapping = "normal";
         try
         {
            skillList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
