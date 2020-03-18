package
{
   import tripwire.containers.WeaponSelectItemContainer;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import fl.motion.motion_internal;
   import flash.geom.Point;
   
   public dynamic class WeaponItemContainerMC extends WeaponSelectItemContainer
   {
       
      
      public var __animFactory_WeaponItemBGaf1:AnimatorFactory3D;
      
      public var __animArray_WeaponItemBGaf1:Array;
      
      public var __motion_WeaponItemBGaf1:MotionBase;
      
      public var __animFactory_WeaponItemRedBGaf1:AnimatorFactory3D;
      
      public var __animArray_WeaponItemRedBGaf1:Array;
      
      public var __motion_WeaponItemRedBGaf1:MotionBase;
      
      public var __animFactory_WeaponInfoContaineraf1:AnimatorFactory3D;
      
      public var __animArray_WeaponInfoContaineraf1:Array;
      
      public var __motion_WeaponInfoContaineraf1:MotionBase;
      
      public var __animFactory_EmptyContaineraf1:AnimatorFactory3D;
      
      public var __animArray_EmptyContaineraf1:Array;
      
      public var __motion_EmptyContaineraf1:MotionBase;
      
      public var __animFactory_Scanlinesaf1:AnimatorFactory3D;
      
      public var __animArray_Scanlinesaf1:Array;
      
      public var __motion_Scanlinesaf1:MotionBase;
      
      public function WeaponItemContainerMC()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,18,this.frame19);
         if(this.__animFactory_WeaponItemBGaf1 == null)
         {
            this.__animArray_WeaponItemBGaf1 = new Array();
            this.__motion_WeaponItemBGaf1 = new MotionBase();
            this.__motion_WeaponItemBGaf1.duration = 19;
            this.__motion_WeaponItemBGaf1.overrideTargetTransform();
            this.__motion_WeaponItemBGaf1.addPropertyArray("x",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("scaleX",[1]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("scaleY",[1]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("skewX",[0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("skewY",[0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("z",[0,0,-14,-28,-42,-56,-70,-84,-98,-112,-112,-98,-84,-70,-56,-42,-28,-14,0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("rotationX",[0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("rotationY",[0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("rotationZ",[0]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponItemBGaf1.addPropertyArray("visible",[true]);
            this.__motion_WeaponItemBGaf1.initFilters(["flash.filters.BlurFilter"],[0],-1,-1);
            this.__motion_WeaponItemBGaf1.addFilterPropertyArray(0,"blurX",[3],-1,-1);
            this.__motion_WeaponItemBGaf1.addFilterPropertyArray(0,"blurY",[3],-1,-1);
            this.__motion_WeaponItemBGaf1.addFilterPropertyArray(0,"quality",[BitmapFilterQuality.LOW],-1,-1);
            this.__motion_WeaponItemBGaf1.motion_internal::initialPosition = [0,0,0];
            this.__motion_WeaponItemBGaf1.is3D = true;
            this.__motion_WeaponItemBGaf1.motion_internal::spanStart = 0;
            this.__animArray_WeaponItemBGaf1.push(this.__motion_WeaponItemBGaf1);
            this.__animFactory_WeaponItemBGaf1 = new AnimatorFactory3D(null,this.__animArray_WeaponItemBGaf1);
            this.__animFactory_WeaponItemBGaf1.addTargetInfo(this,"WeaponItemBG",0,true,0,true,null,-1);
         }
         if(this.__animFactory_WeaponItemRedBGaf1 == null)
         {
            this.__animArray_WeaponItemRedBGaf1 = new Array();
            this.__motion_WeaponItemRedBGaf1 = new MotionBase();
            this.__motion_WeaponItemRedBGaf1.duration = 19;
            this.__motion_WeaponItemRedBGaf1.overrideTargetTransform();
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("x",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("scaleX",[1]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("scaleY",[1]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("skewX",[0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("skewY",[0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("z",[0,0,-14,-28,-42,-56,-70,-84,-98,-112,-112,-98,-84,-70,-56,-42,-28,-14,0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("rotationX",[0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("rotationY",[0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("rotationZ",[0]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponItemRedBGaf1.addPropertyArray("visible",[false]);
            this.__motion_WeaponItemRedBGaf1.initFilters(["flash.filters.BlurFilter"],[0],-1,-1);
            this.__motion_WeaponItemRedBGaf1.addFilterPropertyArray(0,"blurX",[3],-1,-1);
            this.__motion_WeaponItemRedBGaf1.addFilterPropertyArray(0,"blurY",[3],-1,-1);
            this.__motion_WeaponItemRedBGaf1.addFilterPropertyArray(0,"quality",[BitmapFilterQuality.LOW],-1,-1);
            this.__motion_WeaponItemRedBGaf1.motion_internal::transformationPoint = new Point(93.45,0);
            this.__motion_WeaponItemRedBGaf1.motion_internal::initialPosition = [93.45,0,0];
            this.__motion_WeaponItemRedBGaf1.is3D = true;
            this.__motion_WeaponItemRedBGaf1.motion_internal::spanStart = 0;
            this.__animArray_WeaponItemRedBGaf1.push(this.__motion_WeaponItemRedBGaf1);
            this.__animFactory_WeaponItemRedBGaf1 = new AnimatorFactory3D(null,this.__animArray_WeaponItemRedBGaf1);
            this.__animFactory_WeaponItemRedBGaf1.addTargetInfo(this,"WeaponItemRedBG",0,true,0,true,null,-1);
         }
         if(this.__animFactory_WeaponInfoContaineraf1 == null)
         {
            this.__animArray_WeaponInfoContaineraf1 = new Array();
            this.__motion_WeaponInfoContaineraf1 = new MotionBase();
            this.__motion_WeaponInfoContaineraf1.duration = 19;
            this.__motion_WeaponInfoContaineraf1.overrideTargetTransform();
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("x",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("scaleX",[1]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("scaleY",[1]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("skewX",[0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("skewY",[0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("z",[0,0,-14,-28,-42,-56,-70,-84,-98,-112,-112,-98,-84,-70,-56,-42,-28,-14,0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("rotationX",[0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("rotationY",[0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("rotationZ",[0]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponInfoContaineraf1.addPropertyArray("visible",[true]);
            this.__motion_WeaponInfoContaineraf1.motion_internal::transformationPoint = new Point(0.4,0.2);
            this.__motion_WeaponInfoContaineraf1.motion_internal::initialPosition = [0.4,0.2,0];
            this.__motion_WeaponInfoContaineraf1.is3D = true;
            this.__motion_WeaponInfoContaineraf1.motion_internal::spanStart = 0;
            this.__animArray_WeaponInfoContaineraf1.push(this.__motion_WeaponInfoContaineraf1);
            this.__animFactory_WeaponInfoContaineraf1 = new AnimatorFactory3D(null,this.__animArray_WeaponInfoContaineraf1);
            this.__animFactory_WeaponInfoContaineraf1.addTargetInfo(this,"WeaponInfoContainer",0,true,0,true,null,-1);
         }
         if(this.__animFactory_EmptyContaineraf1 == null)
         {
            this.__animArray_EmptyContaineraf1 = new Array();
            this.__motion_EmptyContaineraf1 = new MotionBase();
            this.__motion_EmptyContaineraf1.duration = 19;
            this.__motion_EmptyContaineraf1.overrideTargetTransform();
            this.__motion_EmptyContaineraf1.addPropertyArray("x",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("scaleX",[1.1696,1.1696]);
            this.__motion_EmptyContaineraf1.addPropertyArray("scaleY",[1.1696,1.1696]);
            this.__motion_EmptyContaineraf1.addPropertyArray("skewX",[0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("skewY",[0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("z",[0,0,-14,-28,-42,-56,-70,-84,-98,-112,-112,-98,-84,-70,-56,-42,-28,-14,0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("rotationX",[0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("rotationY",[0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("rotationZ",[0]);
            this.__motion_EmptyContaineraf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_EmptyContaineraf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_EmptyContaineraf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_EmptyContaineraf1.addPropertyArray("visible",[true]);
            this.__motion_EmptyContaineraf1.motion_internal::transformationPoint = new Point(0,-0.45);
            this.__motion_EmptyContaineraf1.motion_internal::initialPosition = [0,-0.55,0];
            this.__motion_EmptyContaineraf1.is3D = true;
            this.__motion_EmptyContaineraf1.motion_internal::spanStart = 0;
            this.__animArray_EmptyContaineraf1.push(this.__motion_EmptyContaineraf1);
            this.__animFactory_EmptyContaineraf1 = new AnimatorFactory3D(null,this.__animArray_EmptyContaineraf1);
            this.__animFactory_EmptyContaineraf1.addTargetInfo(this,"EmptyContainer",0,true,0,true,null,-1);
         }
         if(this.__animFactory_Scanlinesaf1 == null)
         {
            this.__animArray_Scanlinesaf1 = new Array();
            this.__motion_Scanlinesaf1 = new MotionBase();
            this.__motion_Scanlinesaf1.duration = 19;
            this.__motion_Scanlinesaf1.overrideTargetTransform();
            this.__motion_Scanlinesaf1.addPropertyArray("x",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_Scanlinesaf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
            this.__motion_Scanlinesaf1.addPropertyArray("scaleX",[1]);
            this.__motion_Scanlinesaf1.addPropertyArray("scaleY",[1]);
            this.__motion_Scanlinesaf1.addPropertyArray("skewX",[0]);
            this.__motion_Scanlinesaf1.addPropertyArray("skewY",[0]);
            this.__motion_Scanlinesaf1.addPropertyArray("z",[0,0,-14,-28,-42,-56,-70,-84,-98,-112,-112,-98,-84,-70,-56,-42,-28,-14,0]);
            this.__motion_Scanlinesaf1.addPropertyArray("rotationX",[0]);
            this.__motion_Scanlinesaf1.addPropertyArray("rotationY",[0]);
            this.__motion_Scanlinesaf1.addPropertyArray("rotationZ",[0]);
            this.__motion_Scanlinesaf1.addPropertyArray("blendMode",["multiply"]);
            this.__motion_Scanlinesaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_Scanlinesaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_Scanlinesaf1.addPropertyArray("visible",[true]);
            this.__motion_Scanlinesaf1.addPropertyArray("alphaMultiplier",[0.48]);
            this.__motion_Scanlinesaf1.motion_internal::initialPosition = [0,0,0];
            this.__motion_Scanlinesaf1.is3D = true;
            this.__motion_Scanlinesaf1.motion_internal::spanStart = 0;
            this.__animArray_Scanlinesaf1.push(this.__motion_Scanlinesaf1);
            this.__animFactory_Scanlinesaf1 = new AnimatorFactory3D(null,this.__animArray_Scanlinesaf1);
            this.__animFactory_Scanlinesaf1.addTargetInfo(this,"Scanlines",0,true,0,true,null,-1);
         }
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame10() : *
      {
         dispatchEvent(new Event("SelectComplete"));
         stop();
      }
      
      function frame19() : *
      {
         stop();
      }
   }
}
