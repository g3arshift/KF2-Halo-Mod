package com.greensock.plugins
{
   import flash.geom.Transform;
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import com.greensock.core.PropTween;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      public function TintPlugin()
      {
         super("tint,colorTransform,removeTint");
      }
      
      override public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         var _loc4_:ColorTransform = new ColorTransform();
         if(param2 != null && param3.vars.removeTint != true)
         {
            _loc4_.color = uint(param2);
         }
         this._transform = DisplayObject(param1).transform;
         var _loc5_:ColorTransform = this._transform.colorTransform;
         _loc4_.alphaMultiplier = _loc5_.alphaMultiplier;
         _loc4_.alphaOffset = _loc5_.alphaOffset;
         this._init(_loc5_,_loc4_);
         return true;
      }
      
      public function _init(param1:ColorTransform, param2:ColorTransform) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = _props.length;
         while(--_loc3_ > -1)
         {
            _loc4_ = _props[_loc3_];
            if(param1[_loc4_] != param2[_loc4_])
            {
               _addTween(param1,_loc4_,param1[_loc4_],param2[_loc4_],"tint");
            }
         }
      }
      
      override public function setRatio(param1:Number) : void
      {
         var _loc2_:ColorTransform = this._transform.colorTransform;
         var _loc3_:PropTween = _firstPT;
         while(_loc3_)
         {
            _loc2_[_loc3_.p] = _loc3_.c * param1 + _loc3_.s;
            _loc3_ = _loc3_._next;
         }
         this._transform.colorTransform = _loc2_;
      }
   }
}
