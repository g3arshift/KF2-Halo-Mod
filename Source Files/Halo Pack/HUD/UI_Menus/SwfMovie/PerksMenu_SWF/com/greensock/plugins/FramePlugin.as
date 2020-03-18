package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   
   public class FramePlugin extends TweenPlugin
   {
      
      public static const API:Number = 2;
       
      
      public var frame:int;
      
      protected var _target:MovieClip;
      
      public function FramePlugin()
      {
         super("frame,frameLabel,frameForward,frameBackward");
      }
      
      override public function _onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is MovieClip) || isNaN(param2))
         {
            return false;
         }
         this._target = param1 as MovieClip;
         this.frame = this._target.currentFrame;
         _addTween(this,"frame",this.frame,param2,"frame",true);
         return true;
      }
      
      override public function setRatio(param1:Number) : void
      {
         super.setRatio(param1);
         if(this.frame != this._target.currentFrame)
         {
            this._target.gotoAndStop(this.frame);
         }
      }
   }
}
