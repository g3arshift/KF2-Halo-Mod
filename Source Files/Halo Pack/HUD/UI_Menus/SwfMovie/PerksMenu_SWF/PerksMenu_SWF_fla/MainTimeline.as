package PerksMenu_SWF_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var PerksMenu:PerkSelectMenu;
      
      public function MainTimeline()
      {
         super();
         this.__setProp_PerksMenu_Scene1_perkSelection_0();
      }
      
      function __setProp_PerksMenu_Scene1_perkSelection_0() : *
      {
         try
         {
            this.PerksMenu["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.PerksMenu.enabled = true;
         this.PerksMenu.enableInitCallback = true;
         this.PerksMenu.visible = true;
         try
         {
            this.PerksMenu["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
