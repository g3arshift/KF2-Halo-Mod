package
{
   import tripwire.widgets.ControllerWeaponSelectWidget;
   
   public dynamic class ControllerWeaponSelectContainer extends ControllerWeaponSelectWidget
   {
       
      
      public function ControllerWeaponSelectContainer()
      {
         super();
         addFrameScript(0,this.frame1);
         this.__setProp_WeaponCategoryContainer3_ControllerWeaponSelectContainer_WeaponCategory4_0();
         this.__setProp_WeaponCategoryContainer2_ControllerWeaponSelectContainer_WeaponCategory3_0();
         this.__setProp_WeaponCategoryContainer1_ControllerWeaponSelectContainer_WeaponCategory2_0();
      }
      
      function __setProp_WeaponCategoryContainer3_ControllerWeaponSelectContainer_WeaponCategory4_0() : *
      {
         try
         {
            WeaponCategoryContainer3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         WeaponCategoryContainer3.enabled = true;
         WeaponCategoryContainer3.enableInitCallback = false;
         WeaponCategoryContainer3.visible = true;
         WeaponCategoryContainer3.widgetLocation = "UP";
         try
         {
            WeaponCategoryContainer3["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_WeaponCategoryContainer2_ControllerWeaponSelectContainer_WeaponCategory3_0() : *
      {
         try
         {
            WeaponCategoryContainer2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         WeaponCategoryContainer2.enabled = true;
         WeaponCategoryContainer2.enableInitCallback = false;
         WeaponCategoryContainer2.visible = true;
         WeaponCategoryContainer2.widgetLocation = "DOWN";
         try
         {
            WeaponCategoryContainer2["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_WeaponCategoryContainer1_ControllerWeaponSelectContainer_WeaponCategory2_0() : *
      {
         try
         {
            WeaponCategoryContainer1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         WeaponCategoryContainer1.enabled = true;
         WeaponCategoryContainer1.enableInitCallback = false;
         WeaponCategoryContainer1.visible = true;
         WeaponCategoryContainer1.widgetLocation = "RIGHT";
         try
         {
            WeaponCategoryContainer1["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
