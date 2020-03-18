package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class ShortRotationPlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
       
      
      public function ShortRotationPlugin()
      {
         super("shortRotation");
         _overwriteProps.pop();
      }
      
      override public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         if(typeof param2 == "number")
         {
            return false;
         }
         var _loc4_:Boolean = Boolean(param2.useRadians == true);
         for(_loc6_ in param2)
         {
            if(_loc6_ != "useRadians")
            {
               _loc5_ = param1[_loc6_] is Function?Number(_loc9_[_loc6_.indexOf("set") || !("get" + _loc6_.substr(3) in param1)?_loc6_:"get" + _loc6_.substr(3)]()):Number(param1[_loc6_]);
               this._initRotation(param1,_loc6_,_loc5_,typeof param2[_loc6_] == "number"?Number(Number(param2[_loc6_])):Number(_loc5_ + Number(param2[_loc6_].split("=").join(""))),_loc4_);
            }
         }
         return true;
      }
      
      public function _initRotation(param1:Object, param2:String, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         var _loc6_:Number = !!param5?Number(Math.PI * 2):Number(360);
         var _loc7_:Number = (param4 - param3) % _loc6_;
         if(_loc7_ != _loc7_ % (_loc6_ / 2))
         {
            _loc7_ = _loc7_ < 0?Number(_loc7_ + _loc6_):Number(_loc7_ - _loc6_);
         }
         _addTween(param1,param2,param3,param3 + _loc7_,param2);
         _overwriteProps[_overwriteProps.length] = param2;
      }
   }
}
