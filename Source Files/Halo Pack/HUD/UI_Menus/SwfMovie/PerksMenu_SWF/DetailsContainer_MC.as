package
{
   import tripwire.containers.Perks.PerkDetailsContainer;
   
   public dynamic class DetailsContainer_MC extends PerkDetailsContainer
   {
       
      
      public function DetailsContainer_MC()
      {
         super();
         this.__setProp_passivesList_DetailsContainer_MC_PerkPassivesList_0();
      }
      
      function __setProp_passivesList_DetailsContainer_MC_PerkPassivesList_0() : *
      {
         try
         {
            passivesList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         passivesList.enabled = true;
         passivesList.enableInitCallback = false;
         passivesList.focusable = false;
         passivesList.itemRendererName = "SelectPerkPassisvesInfoContainer";
         passivesList.itemRendererInstanceName = "perkBonusField";
         passivesList.margin = 0;
         passivesList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         passivesList.rowHeight = 0;
         passivesList.scrollBar = "";
         passivesList.visible = true;
         passivesList.wrapping = "normal";
         try
         {
            passivesList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
