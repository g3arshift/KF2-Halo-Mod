package tripwire.controls
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.controls.CoreList;
   import flash.filters.BlurFilter;
   
   public class TripList extends UIComponent
   {
       
      
      public function TripList()
      {
         super();
      }
      
      public static function open(param1:CoreList) : *
      {
         param1.focusable = true;
         param1.focused = 1;
         param1.visible = true;
      }
      
      public static function onOpen(param1:CoreList, param2:Boolean = true) : *
      {
         if(param1.selectedIndex == -1 && param2)
         {
            param1.selectedIndex = 0;
         }
         param1.alpha = 1;
         param1.filters = null;
      }
      
      public static function onClose(param1:CoreList) : *
      {
         param1.alpha = 0;
         param1.filters = null;
         param1.visible = false;
      }
      
      public static function getBlurInEffect(param1:Number) : BlurFilter
      {
         var _loc2_:* = (1 - param1) * 500;
         var _loc3_:* = _loc2_ * 0.25;
         return new BlurFilter(_loc2_,_loc3_,1);
      }
      
      public static function getBlurOutEffect(param1:Number) : BlurFilter
      {
         var _loc2_:* = param1 * 500;
         var _loc3_:* = _loc2_ * 0.25;
         return new BlurFilter(_loc2_,_loc3_,1);
      }
   }
}
