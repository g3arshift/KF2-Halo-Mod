package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class RoundPropsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
       
      
      protected var _tween:TweenLite;
      
      public function RoundPropsPlugin()
      {
         super("roundProps",-1);
         _overwriteProps.length = 0;
      }
      
      override public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         this._tween = param3;
         return true;
      }
      
      public function _onInitAllProps() : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:PropTween = null;
         var _loc7_:PropTween = null;
         var _loc1_:Array = this._tween.vars.roundProps is Array?this._tween.vars.roundProps:this._tween.vars.roundProps.split(",");
         var _loc2_:int = _loc1_.length;
         var _loc3_:Object = {};
         var _loc4_:PropTween = this._tween._propLookup.roundProps;
         while(--_loc2_ > -1)
         {
            _loc3_[_loc1_[_loc2_]] = 1;
         }
         _loc2_ = _loc1_.length;
         while(--_loc2_ > -1)
         {
            _loc5_ = _loc1_[_loc2_];
            _loc6_ = this._tween._firstPT;
            while(_loc6_)
            {
               _loc7_ = _loc6_._next;
               if(_loc6_.pg)
               {
                  _loc6_.t._roundProps(_loc3_,true);
               }
               else if(_loc6_.n == _loc5_)
               {
                  this._add(_loc6_.t,_loc5_,_loc6_.s,_loc6_.c);
                  if(_loc7_)
                  {
                     _loc7_._prev = _loc6_._prev;
                  }
                  if(_loc6_._prev)
                  {
                     _loc6_._prev._next = _loc7_;
                  }
                  else if(this._tween._firstPT == _loc6_)
                  {
                     this._tween._firstPT = _loc7_;
                  }
                  _loc6_._next = _loc6_._prev = null;
                  this._tween._propLookup[_loc5_] = _loc4_;
               }
               _loc6_ = _loc7_;
            }
         }
         return false;
      }
      
      public function _add(param1:Object, param2:String, param3:Number, param4:Number) : void
      {
         _addTween(param1,param2,param3,param3 + param4,param2,true);
         _overwriteProps[_overwriteProps.length] = param2;
      }
   }
}
