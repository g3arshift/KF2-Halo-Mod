package com.greensock
{
   import flash.events.IEventDispatcher;
   import flash.display.Shape;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.Animation;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.utils.getTimer;
   import com.greensock.events.TweenEvent;
   import com.greensock.plugins.TweenPlugin;
   import com.greensock.plugins.AutoAlphaPlugin;
   import com.greensock.plugins.EndArrayPlugin;
   import com.greensock.plugins.FramePlugin;
   import com.greensock.plugins.RemoveTintPlugin;
   import com.greensock.plugins.TintPlugin;
   import com.greensock.plugins.VisiblePlugin;
   import com.greensock.plugins.VolumePlugin;
   import com.greensock.plugins.BevelFilterPlugin;
   import com.greensock.plugins.BezierPlugin;
   import com.greensock.plugins.BezierThroughPlugin;
   import com.greensock.plugins.BlurFilterPlugin;
   import com.greensock.plugins.ColorMatrixFilterPlugin;
   import com.greensock.plugins.ColorTransformPlugin;
   import com.greensock.plugins.DropShadowFilterPlugin;
   import com.greensock.plugins.FrameLabelPlugin;
   import com.greensock.plugins.GlowFilterPlugin;
   import com.greensock.plugins.HexColorsPlugin;
   import com.greensock.plugins.RoundPropsPlugin;
   import com.greensock.plugins.ShortRotationPlugin;
   import flash.events.EventDispatcher;
   import com.greensock.core.PropTween;
   import flash.events.Event;
   
   public class TweenMax extends TweenLite implements IEventDispatcher
   {
      
      public static const version:String = "12.1.4";
      
      protected static var _listenerLookup:Object = {
         "onCompleteListener":TweenEvent.COMPLETE,
         "onUpdateListener":TweenEvent.UPDATE,
         "onStartListener":TweenEvent.START,
         "onRepeatListener":TweenEvent.REPEAT,
         "onReverseCompleteListener":TweenEvent.REVERSE_COMPLETE
      };
      
      public static var ticker:Shape = Animation.ticker;
      
      public static var allTo:Function = staggerTo;
      
      public static var allFrom:Function = staggerFrom;
      
      public static var allFromTo:Function = staggerFromTo;
      
      {
         TweenPlugin.activate([AutoAlphaPlugin,EndArrayPlugin,FramePlugin,RemoveTintPlugin,TintPlugin,VisiblePlugin,VolumePlugin,BevelFilterPlugin,BezierPlugin,BezierThroughPlugin,BlurFilterPlugin,ColorMatrixFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin,FrameLabelPlugin,GlowFilterPlugin,HexColorsPlugin,RoundPropsPlugin,ShortRotationPlugin]);
      }
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      protected var _repeat:int = 0;
      
      protected var _repeatDelay:Number = 0;
      
      protected var _cycle:int = 0;
      
      public var _yoyo:Boolean;
      
      public function TweenMax(param1:Object, param2:Number, param3:Object)
      {
         super(param1,param2,param3);
         this._yoyo = this.vars.yoyo == true;
         this._repeat = int(this.vars.repeat);
         this._repeatDelay = Number(this.vars.repeatDelay) || Number(0);
         _dirty = true;
         if(this.vars.onCompleteListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener)
         {
            this._initDispatcher();
            if(_duration == 0)
            {
               if(_delay == 0)
               {
                  if(this.vars.immediateRender)
                  {
                     this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                     this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                  }
               }
            }
         }
      }
      
      public static function killTweensOf(param1:*, param2:* = false, param3:Object = null) : void
      {
         TweenLite.killTweensOf(param1,param2,param3);
      }
      
      public static function killDelayedCallsTo(param1:Function) : void
      {
         TweenLite.killTweensOf(param1);
      }
      
      public static function getTweensOf(param1:*, param2:Boolean = false) : Array
      {
         return TweenLite.getTweensOf(param1,param2);
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         return new TweenMax(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         param3 = _prepVars(param3,true);
         param3.runBackwards = true;
         return new TweenMax(param1,param2,param3);
      }
      
      public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenMax
      {
         param4 = _prepVars(param4,false);
         param3 = _prepVars(param3,false);
         param4.startAt = param3;
         param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
         return new TweenMax(param1,param2,param4);
      }
      
      public static function staggerTo(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         var copy:Object = null;
         var i:int = 0;
         var p:String = null;
         var targets:Array = param1;
         var duration:Number = param2;
         var vars:Object = param3;
         var stagger:Number = param4;
         var onCompleteAll:Function = param5;
         var onCompleteAllParams:Array = param6;
         vars = _prepVars(vars,false);
         var a:Array = [];
         var l:int = targets.length;
         var delay:Number = Number(vars.delay) || Number(0);
         i = 0;
         while(i < l)
         {
            copy = {};
            for(p in vars)
            {
               copy[p] = vars[p];
            }
            copy.delay = delay;
            if(i == l - 1)
            {
               if(onCompleteAll != null)
               {
                  copy.onComplete = function():void
                  {
                     if(vars.onComplete)
                     {
                        vars.onComplete.apply(null,arguments);
                     }
                     onCompleteAll.apply(null,onCompleteAllParams);
                  };
               }
            }
            a[i] = new TweenMax(targets[i],duration,copy);
            delay = delay + stagger;
            i++;
         }
         return a;
      }
      
      public static function staggerFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         param3 = _prepVars(param3,true);
         param3.runBackwards = true;
         if(param3.immediateRender != false)
         {
            param3.immediateRender = true;
         }
         return staggerTo(param1,param2,param3,param4,param5,param6);
      }
      
      public static function staggerFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6:Function = null, param7:Array = null) : Array
      {
         param4 = _prepVars(param4,false);
         param3 = _prepVars(param3,false);
         param4.startAt = param3;
         param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
         return staggerTo(param1,param2,param4,param5,param6,param7);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenMax
      {
         return new TweenMax(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "onReverseComplete":param2,
            "onReverseCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      public static function set(param1:Object, param2:Object) : TweenMax
      {
         return new TweenMax(param1,0,param2);
      }
      
      public static function isTweening(param1:Object) : Boolean
      {
         return TweenLite.getTweensOf(param1,true).length > 0;
      }
      
      public static function getAllTweens(param1:Boolean = false) : Array
      {
         var _loc2_:Array = _getChildrenOf(_rootTimeline,param1);
         return _loc2_.concat(_getChildrenOf(_rootFramesTimeline,param1));
      }
      
      protected static function _getChildrenOf(param1:SimpleTimeline, param2:Boolean) : Array
      {
         if(param1 == null)
         {
            return [];
         }
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         var _loc5_:Animation = param1._first;
         while(_loc5_)
         {
            if(_loc5_ is TweenLite)
            {
               _loc3_[_loc4_++] = _loc5_;
            }
            else
            {
               if(param2)
               {
                  _loc3_[_loc4_++] = _loc5_;
               }
               _loc3_ = _loc3_.concat(_getChildrenOf(SimpleTimeline(_loc5_),param2));
               _loc4_ = _loc3_.length;
            }
            _loc5_ = _loc5_._next;
         }
         return _loc3_;
      }
      
      public static function killAll(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc7_:Boolean = false;
         var _loc9_:Animation = null;
         var _loc10_:int = 0;
         var _loc5_:Array = getAllTweens(param4);
         var _loc6_:int = _loc5_.length;
         var _loc8_:Boolean = param2 && param3 && param4;
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc9_ = _loc5_[_loc10_];
            if(_loc8_ || _loc9_ is SimpleTimeline || (_loc7_ = TweenLite(_loc9_).target == TweenLite(_loc9_).vars.onComplete) && param3 || param2 && !_loc7_)
            {
               if(param1)
               {
                  _loc9_.totalTime(_loc9_.totalDuration());
               }
               else
               {
                  _loc9_._enabled(false,false);
               }
            }
            _loc10_++;
         }
      }
      
      public static function killChildTweensOf(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = getAllTweens(false);
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_containsChildOf(param1,_loc3_[_loc5_].target))
            {
               if(param2)
               {
                  _loc3_[_loc5_].totalTime(_loc3_[_loc5_].totalDuration());
               }
               else
               {
                  _loc3_[_loc5_]._enabled(false,false);
               }
            }
            _loc5_++;
         }
      }
      
      private static function _containsChildOf(param1:DisplayObjectContainer, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObjectContainer = null;
         if(param2 is Array)
         {
            _loc3_ = param2.length;
            while(--_loc3_ > -1)
            {
               if(_containsChildOf(param1,param2[_loc3_]))
               {
                  return true;
               }
            }
         }
         else if(param2 is DisplayObject)
         {
            _loc4_ = param2.parent;
            while(_loc4_)
            {
               if(_loc4_ == param1)
               {
                  return true;
               }
               _loc4_ = _loc4_.parent;
            }
         }
         return false;
      }
      
      public static function pauseAll(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
      {
         _changePause(true,param1,param2,param3);
      }
      
      public static function resumeAll(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
      {
         _changePause(false,param1,param2,param3);
      }
      
      private static function _changePause(param1:Boolean, param2:Boolean = true, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Animation = null;
         var _loc5_:Array = getAllTweens(param4);
         var _loc8_:Boolean = param2 && param3 && param4;
         var _loc9_:int = _loc5_.length;
         while(--_loc9_ > -1)
         {
            _loc7_ = _loc5_[_loc9_];
            _loc6_ = _loc7_ is TweenLite && TweenLite(_loc7_).target == _loc7_.vars.onComplete;
            if(_loc8_ || _loc7_ is SimpleTimeline || _loc6_ && param3 || param2 && !_loc6_)
            {
               _loc7_.paused(param1);
            }
         }
      }
      
      public static function globalTimeScale(param1:Number = NaN) : Number
      {
         if(!arguments.length)
         {
            return _rootTimeline == null?Number(1):Number(_rootTimeline._timeScale);
         }
         param1 = Number(param1) || Number(0.0001);
         if(_rootTimeline == null)
         {
            TweenLite.to({},0,{});
         }
         var _loc3_:SimpleTimeline = _rootTimeline;
         var _loc4_:Number = getTimer() / 1000;
         _loc3_._startTime = _loc4_ - (_loc4_ - _loc3_._startTime) * _loc3_._timeScale / param1;
         _loc3_ = _rootFramesTimeline;
         _loc4_ = _rootFrame;
         _loc3_._startTime = _loc4_ - (_loc4_ - _loc3_._startTime) * _loc3_._timeScale / param1;
         _rootFramesTimeline._timeScale = _rootTimeline._timeScale = param1;
         return param1;
      }
      
      override public function invalidate() : *
      {
         this._yoyo = Boolean(this.vars.yoyo == true);
         this._repeat = int(this.vars.repeat) || 0;
         this._repeatDelay = Number(this.vars.repeatDelay) || Number(0);
         this._hasUpdateListener = false;
         this._initDispatcher();
         _uncache(true);
         return super.invalidate();
      }
      
      public function updateTo(param1:Object, param2:Boolean = false) : *
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:PropTween = null;
         var _loc8_:Number = NaN;
         var _loc3_:Number = ratio;
         if(param2)
         {
            if(_startTime < _timeline._time)
            {
               _startTime = _timeline._time;
               _uncache(false);
               if(_gc)
               {
                  _enabled(true,false);
               }
               else
               {
                  _timeline.insert(this,_startTime - _delay);
               }
            }
         }
         for(_loc4_ in param1)
         {
            this.vars[_loc4_] = param1[_loc4_];
         }
         if(_initted)
         {
            if(param2)
            {
               _initted = false;
            }
            else
            {
               if(_gc)
               {
                  _enabled(true,false);
               }
               if(_notifyPluginsOfEnabled)
               {
                  if(_firstPT != null)
                  {
                     _onPluginEvent("_onDisable",this);
                  }
               }
               if(_time / _duration > 0.998)
               {
                  _loc5_ = _time;
                  this.render(0,true,false);
                  _initted = false;
                  this.render(_loc5_,true,false);
               }
               else if(_time > 0)
               {
                  _initted = false;
                  _init();
                  _loc6_ = 1 / (1 - _loc3_);
                  _loc7_ = _firstPT;
                  while(_loc7_)
                  {
                     _loc8_ = _loc7_.s + _loc7_.c;
                     _loc7_.c = _loc7_.c * _loc6_;
                     _loc7_.s = _loc8_ - _loc7_.c;
                     _loc7_ = _loc7_._next;
                  }
               }
            }
         }
         return this;
      }
      
      override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:PropTween = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         if(!_initted)
         {
            if(_duration === 0 && vars.repeat)
            {
               this.invalidate();
            }
         }
         var _loc4_:Number = !_dirty?Number(_totalDuration):Number(this.totalDuration());
         var _loc5_:Number = _time;
         var _loc6_:Number = _totalTime;
         var _loc7_:Number = this._cycle;
         if(param1 >= _loc4_)
         {
            _totalTime = _loc4_;
            this._cycle = this._repeat;
            if(this._yoyo && (this._cycle & 1) != 0)
            {
               _time = 0;
               ratio = !!_ease._calcEnd?Number(_ease.getRatio(0)):Number(0);
            }
            else
            {
               _time = _duration;
               ratio = !!_ease._calcEnd?Number(_ease.getRatio(1)):Number(1);
            }
            if(!_reversed)
            {
               _loc8_ = true;
               _loc9_ = "onComplete";
            }
            if(_duration == 0)
            {
               _loc11_ = _rawPrevTime;
               if(_startTime === _timeline._duration)
               {
                  param1 = 0;
               }
               if(param1 === 0 || _loc11_ < 0 || _loc11_ === _tinyNum)
               {
                  if(_loc11_ !== param1)
                  {
                     param3 = true;
                     if(_loc11_ > _tinyNum)
                     {
                        _loc9_ = "onReverseComplete";
                     }
                  }
               }
               _rawPrevTime = _loc11_ = !param2 || param1 !== 0 || _rawPrevTime === param1?Number(param1):Number(_tinyNum);
            }
         }
         else if(param1 < 1.0e-7)
         {
            _totalTime = _time = this._cycle = 0;
            ratio = !!_ease._calcEnd?Number(_ease.getRatio(0)):Number(0);
            if(_loc6_ !== 0 || _duration === 0 && _rawPrevTime > 0 && _rawPrevTime !== _tinyNum)
            {
               _loc9_ = "onReverseComplete";
               _loc8_ = _reversed;
            }
            if(param1 < 0)
            {
               _active = false;
               if(_duration == 0)
               {
                  if(_rawPrevTime >= 0)
                  {
                     param3 = true;
                  }
                  _rawPrevTime = _loc11_ = !param2 || param1 !== 0 || _rawPrevTime === param1?Number(param1):Number(_tinyNum);
               }
            }
            else if(!_initted)
            {
               param3 = true;
            }
         }
         else
         {
            _totalTime = _time = param1;
            if(this._repeat != 0)
            {
               _loc12_ = _duration + this._repeatDelay;
               this._cycle = _totalTime / _loc12_ >> 0;
               if(this._cycle !== 0)
               {
                  if(this._cycle === _totalTime / _loc12_)
                  {
                     this._cycle--;
                  }
               }
               _time = _totalTime - this._cycle * _loc12_;
               if(this._yoyo)
               {
                  if((this._cycle & 1) != 0)
                  {
                     _time = _duration - _time;
                  }
               }
               if(_time > _duration)
               {
                  _time = _duration;
               }
               else if(_time < 0)
               {
                  _time = 0;
               }
            }
            if(_easeType)
            {
               _loc13_ = _time / _duration;
               _loc14_ = _easeType;
               _loc15_ = _easePower;
               if(_loc14_ == 1 || _loc14_ == 3 && _loc13_ >= 0.5)
               {
                  _loc13_ = 1 - _loc13_;
               }
               if(_loc14_ == 3)
               {
                  _loc13_ = _loc13_ * 2;
               }
               if(_loc15_ == 1)
               {
                  _loc13_ = _loc13_ * _loc13_;
               }
               else if(_loc15_ == 2)
               {
                  _loc13_ = _loc13_ * (_loc13_ * _loc13_);
               }
               else if(_loc15_ == 3)
               {
                  _loc13_ = _loc13_ * (_loc13_ * _loc13_ * _loc13_);
               }
               else if(_loc15_ == 4)
               {
                  _loc13_ = _loc13_ * (_loc13_ * _loc13_ * _loc13_ * _loc13_);
               }
               if(_loc14_ == 1)
               {
                  ratio = 1 - _loc13_;
               }
               else if(_loc14_ == 2)
               {
                  ratio = _loc13_;
               }
               else if(_time / _duration < 0.5)
               {
                  ratio = _loc13_ / 2;
               }
               else
               {
                  ratio = 1 - _loc13_ / 2;
               }
            }
            else
            {
               ratio = _ease.getRatio(_time / _duration);
            }
         }
         if(_loc5_ == _time && !param3 && this._cycle === _loc7_)
         {
            if(_loc6_ !== _totalTime)
            {
               if(_onUpdate != null)
               {
                  if(!param2)
                  {
                     _onUpdate.apply(vars.onUpdateScope || this,vars.onUpdateParams);
                  }
               }
            }
            return;
         }
         if(!_initted)
         {
            _init();
            if(!_initted || _gc)
            {
               return;
            }
            if(_time && !_loc8_)
            {
               ratio = _ease.getRatio(_time / _duration);
            }
            else if(_loc8_ && _ease._calcEnd)
            {
               ratio = _ease.getRatio(_time === 0?Number(0):Number(1));
            }
         }
         if(!_active)
         {
            if(!_paused && _time !== _loc5_ && param1 >= 0)
            {
               _active = true;
            }
         }
         if(_loc6_ == 0)
         {
            if(_startAt != null)
            {
               if(param1 >= 0)
               {
                  _startAt.render(param1,param2,param3);
               }
               else if(!_loc9_)
               {
                  _loc9_ = "_dummyGS";
               }
            }
            if(_totalTime != 0 || _duration == 0)
            {
               if(!param2)
               {
                  if(vars.onStart)
                  {
                     vars.onStart.apply(null,vars.onStartParams);
                  }
                  if(this._dispatcher)
                  {
                     this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                  }
               }
            }
         }
         _loc10_ = _firstPT;
         while(_loc10_)
         {
            if(_loc10_.f)
            {
               _loc10_.t[_loc10_.p](_loc10_.c * ratio + _loc10_.s);
            }
            else
            {
               _loc10_.t[_loc10_.p] = _loc10_.c * ratio + _loc10_.s;
            }
            _loc10_ = _loc10_._next;
         }
         if(_onUpdate != null)
         {
            if(param1 < 0 && _startAt != null && _startTime != 0)
            {
               _startAt.render(param1,param2,param3);
            }
            if(!param2)
            {
               if(_totalTime !== _loc6_ || _loc8_)
               {
                  _onUpdate.apply(null,vars.onUpdateParams);
               }
            }
         }
         if(this._hasUpdateListener)
         {
            if(param1 < 0 && _startAt != null && _onUpdate == null && _startTime != 0)
            {
               _startAt.render(param1,param2,param3);
            }
            if(!param2)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            }
         }
         if(this._cycle != _loc7_)
         {
            if(!param2)
            {
               if(!_gc)
               {
                  if(vars.onRepeat)
                  {
                     vars.onRepeat.apply(null,vars.onRepeatParams);
                  }
                  if(this._dispatcher)
                  {
                     this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                  }
               }
            }
         }
         if(_loc9_)
         {
            if(!_gc)
            {
               if(param1 < 0 && _startAt != null && _onUpdate == null && !this._hasUpdateListener && _startTime != 0)
               {
                  _startAt.render(param1,param2,true);
               }
               if(_loc8_)
               {
                  if(_timeline.autoRemoveChildren)
                  {
                     _enabled(false,false);
                  }
                  _active = false;
               }
               if(!param2)
               {
                  if(vars[_loc9_])
                  {
                     vars[_loc9_].apply(null,vars[_loc9_ + "Params"]);
                  }
                  if(this._dispatcher)
                  {
                     this._dispatcher.dispatchEvent(new TweenEvent(_loc9_ == "onComplete"?TweenEvent.COMPLETE:TweenEvent.REVERSE_COMPLETE));
                  }
               }
               if(_duration === 0 && _rawPrevTime === _tinyNum && _loc11_ !== _tinyNum)
               {
                  _rawPrevTime = 0;
               }
            }
         }
      }
      
      protected function _initDispatcher() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         for(_loc2_ in _listenerLookup)
         {
            if(_loc2_ in vars)
            {
               if(vars[_loc2_] is Function)
               {
                  if(this._dispatcher == null)
                  {
                     this._dispatcher = new EventDispatcher(this);
                  }
                  this._dispatcher.addEventListener(_listenerLookup[_loc2_],vars[_loc2_],false,0,true);
                  _loc1_ = true;
               }
            }
         }
         return _loc1_;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this._dispatcher == null)
         {
            this._dispatcher = new EventDispatcher(this);
         }
         if(param1 == TweenEvent.UPDATE)
         {
            this._hasUpdateListener = true;
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(this._dispatcher)
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._dispatcher == null?false:Boolean(this._dispatcher.hasEventListener(param1));
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._dispatcher == null?false:Boolean(this._dispatcher.willTrigger(param1));
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._dispatcher == null?false:Boolean(this._dispatcher.dispatchEvent(param1));
      }
      
      override public function progress(param1:Number = NaN, param2:Boolean = false) : *
      {
         return !arguments.length?_time / this.duration():totalTime(this.duration() * (this._yoyo && (this._cycle & 1) !== 0?1 - param1:param1) + this._cycle * (_duration + this._repeatDelay),param2);
      }
      
      override public function totalProgress(param1:Number = NaN, param2:Boolean = false) : *
      {
         return !arguments.length?_totalTime / this.totalDuration():totalTime(this.totalDuration() * param1,param2);
      }
      
      override public function time(param1:Number = NaN, param2:Boolean = false) : *
      {
         if(!arguments.length)
         {
            return _time;
         }
         if(_dirty)
         {
            this.totalDuration();
         }
         if(param1 > _duration)
         {
            param1 = _duration;
         }
         if(this._yoyo && (this._cycle & 1) !== 0)
         {
            param1 = _duration - param1 + this._cycle * (_duration + this._repeatDelay);
         }
         else if(this._repeat != 0)
         {
            param1 = param1 + this._cycle * (_duration + this._repeatDelay);
         }
         return totalTime(param1,param2);
      }
      
      override public function duration(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            return this._duration;
         }
         return super.duration(param1);
      }
      
      override public function totalDuration(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            if(_dirty)
            {
               _totalDuration = this._repeat == -1?Number(999999999999):Number(_duration * (this._repeat + 1) + this._repeatDelay * this._repeat);
               _dirty = false;
            }
            return _totalDuration;
         }
         return this._repeat == -1?this:this.duration((param1 - this._repeat * this._repeatDelay) / (this._repeat + 1));
      }
      
      public function repeat(param1:int = 0) : *
      {
         if(!arguments.length)
         {
            return this._repeat;
         }
         this._repeat = param1;
         return _uncache(true);
      }
      
      public function repeatDelay(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            return this._repeatDelay;
         }
         this._repeatDelay = param1;
         return _uncache(true);
      }
      
      public function yoyo(param1:Boolean = false) : *
      {
         if(!arguments.length)
         {
            return this._yoyo;
         }
         this._yoyo = param1;
         return this;
      }
   }
}
