package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class EndArrayPlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
       
      
      protected var _a:Array;
      
      protected var _round:Boolean;
      
      protected var _info:Array;
      
      public function EndArrayPlugin()
      {
         this._info = [];
         super("endArray");
      }
      
      override public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is Array) || !(param2 is Array))
         {
            return false;
         }
         this._init(param1 as Array,param2);
         return true;
      }
      
      public function _init(param1:Array, param2:Array) : void
      {
         this._a = param1;
         var _loc3_:int = param2.length;
         var _loc4_:int = 0;
         while(--_loc3_ > -1)
         {
            if(param1[_loc3_] != param2[_loc3_] && param1[_loc3_] != null)
            {
               this._info[_loc4_++] = new ArrayTweenInfo(_loc3_,this._a[_loc3_],param2[_loc3_] - this._a[_loc3_]);
            }
         }
      }
      
      override public function _roundProps(param1:Object, param2:Boolean = true) : void
      {
         if("endArray" in param1)
         {
            this._round = param2;
         }
      }
      
      override public function setRatio(param1:Number) : void
      {
         var _loc3_:ArrayTweenInfo = null;
         var _loc4_:Number = NaN;
         var _loc2_:int = this._info.length;
         if(this._round)
         {
            while(--_loc2_ > -1)
            {
               _loc3_ = this._info[_loc2_];
               this._a[_loc3_.i] = (_loc4_ = Number(_loc3_.c * param1 + _loc3_.s)) > 0?_loc4_ + 0.5 >> 0:_loc4_ - 0.5 >> 0;
            }
         }
         else
         {
            while(--_loc2_ > -1)
            {
               _loc3_ = this._info[_loc2_];
               this._a[_loc3_.i] = _loc3_.c * param1 + _loc3_.s;
            }
         }
      }
   }
}

class ArrayTweenInfo
{
    
   
   public var i:uint;
   
   public var s:Number;
   
   public var c:Number;
   
   function ArrayTweenInfo(param1:uint, param2:Number, param3:Number)
   {
      super();
      this.i = param1;
      this.s = param2;
      this.c = param3;
   }
}
