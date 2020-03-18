package tripwire.Tools
{
   import flash.geom.Point;
   import flash.display.DisplayObject;
   
   public class TextfieldUtil
   {
      
      private static var _instance:tripwire.Tools.TextfieldUtil;
      
      private static var originalPoint:Point = new Point();
       
      
      public function TextfieldUtil()
      {
         super();
         if(_instance != null)
         {
            return;
         }
      }
      
      public static function get instance() : tripwire.Tools.TextfieldUtil
      {
         if(_instance == null)
         {
            _instance = new tripwire.Tools.TextfieldUtil();
         }
         return _instance;
      }
      
      public function InvalidateFilteredDisplayObject(param1:DisplayObject) : *
      {
         originalPoint.x = param1.x;
         originalPoint.y = param1.y;
         param1.x = (param1.x + 1) * 1000;
         param1.y = (param1.x + 1) * 1000;
         param1.x = originalPoint.x;
         param1.y = originalPoint.y;
      }
      
      public function getFormattedTimeFromSeconds(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         _loc2_ = param1 / 60;
         param1 = param1 - _loc2_ * 60;
         _loc3_ = _loc3_ + (_loc2_ + ":");
         if(param1 >= 10)
         {
            _loc3_ = _loc3_ + param1;
         }
         else
         {
            _loc3_ = _loc3_ + "0" + param1;
         }
         return _loc3_;
      }
   }
}
