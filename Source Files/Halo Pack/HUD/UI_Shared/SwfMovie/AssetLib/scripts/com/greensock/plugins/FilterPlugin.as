package com.greensock.plugins
{
   import flash.filters.BitmapFilter;
   import com.greensock.TweenLite;
   import flash.filters.BlurFilter;
   
   public class FilterPlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
       
      
      protected var _target:Object;
      
      protected var _type:Class;
      
      protected var _filter:BitmapFilter;
      
      protected var _index:int;
      
      protected var _remove:Boolean;
      
      private var _tween:TweenLite;
      
      public function FilterPlugin(param1:String = "", param2:Number = 0)
      {
         super(param1,param2);
      }
      
      protected function _initFilter(param1:*, param2:Object, param3:TweenLite, param4:Class, param5:BitmapFilter, param6:Array) : Boolean
      {
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:HexColorsPlugin = null;
         this._target = param1;
         this._tween = param3;
         this._type = param4;
         var _loc7_:Array = this._target.filters;
         var _loc11_:Object = param2 is BitmapFilter?{}:param2;
         if(_loc11_.index != null)
         {
            this._index = _loc11_.index;
         }
         else
         {
            this._index = _loc7_.length;
            if(_loc11_.addFilter != true)
            {
               do
               {
               }
               while(--this._index > -1 && !(_loc7_[this._index] is this._type));
               
            }
         }
         if(this._index < 0 || !(_loc7_[this._index] is this._type))
         {
            if(this._index < 0)
            {
               this._index = _loc7_.length;
            }
            if(this._index > _loc7_.length)
            {
               _loc9_ = _loc7_.length - 1;
               while(++_loc9_ < this._index)
               {
                  _loc7_[_loc9_] = new BlurFilter(0,0,1);
               }
            }
            _loc7_[this._index] = param5;
            this._target.filters = _loc7_;
         }
         this._filter = _loc7_[this._index];
         this._remove = _loc11_.remove == true;
         _loc9_ = param6.length;
         while(--_loc9_ > -1)
         {
            _loc8_ = param6[_loc9_];
            if(_loc8_ in param2 && this._filter[_loc8_] != param2[_loc8_])
            {
               if(_loc8_ == "color" || _loc8_ == "highlightColor" || _loc8_ == "shadowColor")
               {
                  _loc10_ = new HexColorsPlugin();
                  _loc10_._initColor(this._filter,_loc8_,param2[_loc8_]);
                  _addTween(_loc10_,"setRatio",0,1,_propName);
               }
               else if(_loc8_ == "quality" || _loc8_ == "inner" || _loc8_ == "knockout" || _loc8_ == "hideObject")
               {
                  this._filter[_loc8_] = param2[_loc8_];
               }
               else
               {
                  _addTween(this._filter,_loc8_,this._filter[_loc8_],param2[_loc8_],_propName);
               }
            }
         }
         return true;
      }
      
      override public function setRatio(param1:Number) : void
      {
         super.setRatio(param1);
         var _loc2_:Array = this._target.filters;
         if(!(_loc2_[this._index] is this._type))
         {
            this._index = _loc2_.length;
            do
            {
            }
            while(--this._index > -1 && !(_loc2_[this._index] is this._type));
            
            if(this._index == -1)
            {
               this._index = _loc2_.length;
            }
         }
         if(param1 == 1 && this._remove && this._tween._time == this._tween._duration && this._tween.data != "isFromStart")
         {
            if(this._index < _loc2_.length)
            {
               _loc2_.splice(this._index,1);
            }
         }
         else
         {
            _loc2_[this._index] = this._filter;
         }
         this._target.filters = _loc2_;
      }
   }
}
