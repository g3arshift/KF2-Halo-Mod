package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class TweenPlugin
   {
      
      public static const version:String = "12.0.13";
      
      public static const API:Number = 2;
       
      
      public var _propName:String;
      
      public var _overwriteProps:Array;
      
      public var _priority:int = 0;
      
      protected var _firstPT:PropTween;
      
      public function TweenPlugin(param1:String = "", param2:int = 0)
      {
         super();
         this._overwriteProps = param1.split(",");
         this._propName = this._overwriteProps[0];
         this._priority = int(param2) || 0;
      }
      
      private static function _onTweenEvent(param1:String, param2:TweenLite) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:PropTween = null;
         var _loc6_:PropTween = null;
         var _loc7_:PropTween = null;
         var _loc8_:PropTween = null;
         var _loc3_:PropTween = param2._firstPT;
         if(param1 == "_onInitAllProps")
         {
            while(_loc3_)
            {
               _loc8_ = _loc3_._next;
               _loc5_ = _loc6_;
               while(_loc5_ && _loc5_.pr > _loc3_.pr)
               {
                  _loc5_ = _loc5_._next;
               }
               if(_loc3_._prev = !!_loc5_?_loc5_._prev:_loc7_)
               {
                  _loc3_._prev._next = _loc3_;
               }
               else
               {
                  _loc6_ = _loc3_;
               }
               if(_loc3_._next = _loc5_)
               {
                  _loc5_._prev = _loc3_;
               }
               else
               {
                  _loc7_ = _loc3_;
               }
               _loc3_ = _loc8_;
            }
            _loc3_ = param2._firstPT = _loc6_;
         }
         while(_loc3_)
         {
            if(_loc3_.pg)
            {
               if(param1 in _loc3_.t)
               {
                  if(_loc3_.t[param1]())
                  {
                     _loc4_ = true;
                  }
               }
            }
            _loc3_ = _loc3_._next;
         }
         return _loc4_;
      }
      
      public static function activate(param1:Array) : Boolean
      {
         TweenLite._onPluginEvent = TweenPlugin._onTweenEvent;
         var _loc2_:int = param1.length;
         while(--_loc2_ > -1)
         {
            if(param1[_loc2_].API == TweenPlugin.API)
            {
               TweenLite._plugins[new (param1[_loc2_] as Class)()._propName] = param1[_loc2_];
            }
         }
         return true;
      }
      
      public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         return false;
      }
      
      protected function _addTween(param1:Object, param2:String, param3:Number, param4:*, param5:String = null, param6:Boolean = false) : PropTween
      {
         var _loc7_:Number = NaN;
         if(param4 != null && (_loc7_ = typeof param4 === "number" || param4.charAt(1) !== "="?Number(Number(param4) - param3):Number(int(param4.charAt(0) + "1") * Number(param4.substr(2)))))
         {
            this._firstPT = new PropTween(param1,param2,param3,_loc7_,param5 || param2,false,this._firstPT);
            this._firstPT.r = param6;
            return this._firstPT;
         }
         return null;
      }
      
      public function setRatio(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:PropTween = this._firstPT;
         while(_loc2_)
         {
            _loc3_ = _loc2_.c * param1 + _loc2_.s;
            if(_loc2_.r)
            {
               _loc3_ = _loc3_ + (_loc3_ > 0?0.5:-0.5) | 0;
            }
            if(_loc2_.f)
            {
               _loc2_.t[_loc2_.p](_loc3_);
            }
            else
            {
               _loc2_.t[_loc2_.p] = _loc3_;
            }
            _loc2_ = _loc2_._next;
         }
      }
      
      public function _roundProps(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:PropTween = this._firstPT;
         while(_loc3_)
         {
            if(this._propName in param1 || _loc3_.n != null && _loc3_.n.split(this._propName + "_").join("") in param1)
            {
               _loc3_.r = param2;
            }
            _loc3_ = _loc3_._next;
         }
      }
      
      public function _kill(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         if(this._propName in param1)
         {
            this._overwriteProps = [];
         }
         else
         {
            _loc3_ = this._overwriteProps.length;
            while(--_loc3_ > -1)
            {
               if(this._overwriteProps[_loc3_] in param1)
               {
                  this._overwriteProps.splice(_loc3_,1);
               }
            }
         }
         var _loc2_:PropTween = this._firstPT;
         while(_loc2_)
         {
            if(_loc2_.n in param1)
            {
               if(_loc2_._next)
               {
                  _loc2_._next._prev = _loc2_._prev;
               }
               if(_loc2_._prev)
               {
                  _loc2_._prev._next = _loc2_._next;
                  _loc2_._prev = null;
               }
               else if(this._firstPT == _loc2_)
               {
                  this._firstPT = _loc2_._next;
               }
            }
            _loc2_ = _loc2_._next;
         }
         return false;
      }
   }
}
