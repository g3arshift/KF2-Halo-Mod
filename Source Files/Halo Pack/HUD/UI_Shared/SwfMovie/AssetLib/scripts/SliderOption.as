package
{
   public dynamic class SliderOption extends tripwire.controls.SliderOption
   {
       
      
      public function SliderOption()
      {
         super();
         this.__setProp_slider_$SliderOptionMC_Slider_0();
      }
      
      function __setProp_slider_$SliderOptionMC_Slider_0() : *
      {
         try
         {
            slider["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         slider.enabled = true;
         slider.enableInitCallback = false;
         slider.focusable = false;
         slider.liveDragging = true;
         slider.maximum = 100;
         slider.minimum = 0;
         slider.offsetLeft = 24;
         slider.offsetRight = 0;
         slider.snapInterval = 1;
         slider.snapping = true;
         slider.value = 0;
         slider.visible = true;
         try
         {
            slider["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
