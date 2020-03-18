package
{
   import tripwire.widgets.BossNameplateWidget;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import adobe.utils.*;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   
   public dynamic class BossNamePlate extends BossNameplateWidget
   {
       
      
      public var __animFactory_bossNameContaineraf1:AnimatorFactory3D;
      
      public var __animArray_bossNameContaineraf1:Array;
      
      public var ____motion_bossNameContaineraf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_bossNameContaineraf1_matArray__:Array;
      
      public var __motion_bossNameContaineraf1:MotionBase;
      
      public var __animFactory_subTextContaineraf1:AnimatorFactory3D;
      
      public var __animArray_subTextContaineraf1:Array;
      
      public var ____motion_subTextContaineraf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_subTextContaineraf1_matArray__:Array;
      
      public var __motion_subTextContaineraf1:MotionBase;
      
      public function BossNamePlate()
      {
         super();
         addFrameScript(0,this.frame1,29,this.frame30);
         if(this.__animFactory_bossNameContaineraf1 == null)
         {
            this.__animArray_bossNameContaineraf1 = new Array();
            this.__motion_bossNameContaineraf1 = new MotionBase();
            this.__motion_bossNameContaineraf1.duration = 11;
            this.__motion_bossNameContaineraf1.overrideTargetTransform();
            this.__motion_bossNameContaineraf1.addPropertyArray("blendMode",["normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal"]);
            this.__motion_bossNameContaineraf1.addPropertyArray("cacheAsBitmap",[false,false,false,false,false,false,false,false,false,false,false]);
            this.__motion_bossNameContaineraf1.addPropertyArray("opaqueBackground",[null,null,null,null,null,null,null,null,null,null,null]);
            this.__motion_bossNameContaineraf1.addPropertyArray("visible",[true,true,true,true,true,true,true,true,true,true,true]);
            this.__motion_bossNameContaineraf1.is3D = true;
            this.__motion_bossNameContaineraf1.motion_internal::spanStart = 0;
            this.____motion_bossNameContaineraf1_matArray__ = new Array();
            this.____motion_bossNameContaineraf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_bossNameContaineraf1_mat3DVec__[0] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[1] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[2] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[3] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[4] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[5] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[6] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[7] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[8] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[9] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[10] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[11] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[12] = 128;
            this.____motion_bossNameContaineraf1_mat3DVec__[13] = 320;
            this.____motion_bossNameContaineraf1_mat3DVec__[14] = -128;
            this.____motion_bossNameContaineraf1_mat3DVec__[15] = 1;
            this.____motion_bossNameContaineraf1_matArray__.push(new Matrix3D(this.____motion_bossNameContaineraf1_mat3DVec__));
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.__motion_bossNameContaineraf1.addPropertyArray("matrix3D",this.____motion_bossNameContaineraf1_matArray__);
            this.__animArray_bossNameContaineraf1.push(this.__motion_bossNameContaineraf1);
            this.__motion_bossNameContaineraf1 = new MotionBase();
            this.__motion_bossNameContaineraf1.duration = 9;
            this.__motion_bossNameContaineraf1.overrideTargetTransform();
            this.__motion_bossNameContaineraf1.addPropertyArray("x",[0,-15,-30,-45,-60,-65,-70,-75,-80]);
            this.__motion_bossNameContaineraf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("scaleX",[1,1,1,1,1,1,1,1,1]);
            this.__motion_bossNameContaineraf1.addPropertyArray("scaleY",[1,1,1,1,1,1,1,1,1]);
            this.__motion_bossNameContaineraf1.addPropertyArray("skewX",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("skewY",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("z",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("rotationX",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("rotationY",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("rotationZ",[0,0,0,0,0,0,0,0,0]);
            this.__motion_bossNameContaineraf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_bossNameContaineraf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_bossNameContaineraf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_bossNameContaineraf1.addPropertyArray("visible",[true]);
            this.__motion_bossNameContaineraf1.addPropertyArray("alphaMultiplier",[0.48,0.5775,0.675,0.7725,0.87,0.9025,0.935,0.9675,1]);
            this.__motion_bossNameContaineraf1.motion_internal::transformationPoint = new Point(457,60.2);
            this.__motion_bossNameContaineraf1.motion_internal::initialPosition = [649,380.2,-128];
            this.__motion_bossNameContaineraf1.is3D = true;
            this.__motion_bossNameContaineraf1.motion_internal::spanStart = 11;
            this.__animArray_bossNameContaineraf1.push(this.__motion_bossNameContaineraf1);
            this.__motion_bossNameContaineraf1 = new MotionBase();
            this.__motion_bossNameContaineraf1.duration = 10;
            this.__motion_bossNameContaineraf1.overrideTargetTransform();
            this.__motion_bossNameContaineraf1.addPropertyArray("blendMode",["normal","normal","normal","normal","normal","normal","normal","normal","normal","normal"]);
            this.__motion_bossNameContaineraf1.addPropertyArray("cacheAsBitmap",[false,false,false,false,false,false,false,false,false,false]);
            this.__motion_bossNameContaineraf1.addPropertyArray("opaqueBackground",[null,null,null,null,null,null,null,null,null,null]);
            this.__motion_bossNameContaineraf1.addPropertyArray("visible",[true,true,true,true,true,true,true,true,true,true]);
            this.__motion_bossNameContaineraf1.is3D = true;
            this.__motion_bossNameContaineraf1.motion_internal::spanStart = 20;
            this.____motion_bossNameContaineraf1_matArray__ = new Array();
            this.____motion_bossNameContaineraf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_bossNameContaineraf1_mat3DVec__[0] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[1] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[2] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[3] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[4] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[5] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[6] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[7] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[8] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[9] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[10] = 1;
            this.____motion_bossNameContaineraf1_mat3DVec__[11] = 0;
            this.____motion_bossNameContaineraf1_mat3DVec__[12] = 112;
            this.____motion_bossNameContaineraf1_mat3DVec__[13] = 320;
            this.____motion_bossNameContaineraf1_mat3DVec__[14] = -128;
            this.____motion_bossNameContaineraf1_mat3DVec__[15] = 1;
            this.____motion_bossNameContaineraf1_matArray__.push(new Matrix3D(this.____motion_bossNameContaineraf1_mat3DVec__));
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.____motion_bossNameContaineraf1_matArray__.push(null);
            this.__motion_bossNameContaineraf1.addPropertyArray("matrix3D",this.____motion_bossNameContaineraf1_matArray__);
            this.__animArray_bossNameContaineraf1.push(this.__motion_bossNameContaineraf1);
            this.__animFactory_bossNameContaineraf1 = new AnimatorFactory3D(null,this.__animArray_bossNameContaineraf1);
            this.__animFactory_bossNameContaineraf1.addTargetInfo(this,"bossNameContainer",0,true,0,true,null,-1);
         }
         if(this.__animFactory_subTextContaineraf1 == null)
         {
            this.__animArray_subTextContaineraf1 = new Array();
            this.__motion_subTextContaineraf1 = new MotionBase();
            this.__motion_subTextContaineraf1.duration = 20;
            this.__motion_subTextContaineraf1.overrideTargetTransform();
            this.__motion_subTextContaineraf1.addPropertyArray("blendMode",["normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal"]);
            this.__motion_subTextContaineraf1.addPropertyArray("cacheAsBitmap",[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]);
            this.__motion_subTextContaineraf1.addPropertyArray("opaqueBackground",[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]);
            this.__motion_subTextContaineraf1.addPropertyArray("visible",[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]);
            this.__motion_subTextContaineraf1.is3D = true;
            this.__motion_subTextContaineraf1.motion_internal::spanStart = 0;
            this.____motion_subTextContaineraf1_matArray__ = new Array();
            this.____motion_subTextContaineraf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_subTextContaineraf1_mat3DVec__[0] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[1] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[2] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[3] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[4] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[5] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[6] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[7] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[8] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[9] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[10] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[11] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[12] = 335;
            this.____motion_subTextContaineraf1_mat3DVec__[13] = 378.25;
            this.____motion_subTextContaineraf1_mat3DVec__[14] = -128;
            this.____motion_subTextContaineraf1_mat3DVec__[15] = 1;
            this.____motion_subTextContaineraf1_matArray__.push(new Matrix3D(this.____motion_subTextContaineraf1_mat3DVec__));
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.____motion_subTextContaineraf1_matArray__.push(null);
            this.__motion_subTextContaineraf1.addPropertyArray("matrix3D",this.____motion_subTextContaineraf1_matArray__);
            this.__animArray_subTextContaineraf1.push(this.__motion_subTextContaineraf1);
            this.__motion_subTextContaineraf1 = new MotionBase();
            this.__motion_subTextContaineraf1.duration = 9;
            this.__motion_subTextContaineraf1.overrideTargetTransform();
            this.__motion_subTextContaineraf1.addPropertyArray("x",[0,-15,-30,-45,-60,-65,-70,-75,-80]);
            this.__motion_subTextContaineraf1.addPropertyArray("y",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("scaleX",[1,1,1,1,1,1,1,1,1]);
            this.__motion_subTextContaineraf1.addPropertyArray("scaleY",[1,1,1,1,1,1,1,1,1]);
            this.__motion_subTextContaineraf1.addPropertyArray("skewX",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("skewY",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("z",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("rotationX",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("rotationY",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("rotationZ",[0,0,0,0,0,0,0,0,0]);
            this.__motion_subTextContaineraf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_subTextContaineraf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_subTextContaineraf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_subTextContaineraf1.addPropertyArray("visible",[true]);
            this.__motion_subTextContaineraf1.addPropertyArray("alphaMultiplier",[0.48,0.5775,0.675,0.7725,0.87,0.9025,0.935,0.9675,1]);
            this.__motion_subTextContaineraf1.motion_internal::transformationPoint = new Point(295.65,33.25);
            this.__motion_subTextContaineraf1.motion_internal::initialPosition = [694.65,411.5,-128];
            this.__motion_subTextContaineraf1.is3D = true;
            this.__motion_subTextContaineraf1.motion_internal::spanStart = 20;
            this.__animArray_subTextContaineraf1.push(this.__motion_subTextContaineraf1);
            this.__motion_subTextContaineraf1 = new MotionBase();
            this.__motion_subTextContaineraf1.duration = 1;
            this.__motion_subTextContaineraf1.overrideTargetTransform();
            this.__motion_subTextContaineraf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_subTextContaineraf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_subTextContaineraf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_subTextContaineraf1.addPropertyArray("visible",[true]);
            this.__motion_subTextContaineraf1.is3D = true;
            this.__motion_subTextContaineraf1.motion_internal::spanStart = 29;
            this.____motion_subTextContaineraf1_matArray__ = new Array();
            this.____motion_subTextContaineraf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_subTextContaineraf1_mat3DVec__[0] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[1] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[2] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[3] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[4] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[5] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[6] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[7] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[8] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[9] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[10] = 1;
            this.____motion_subTextContaineraf1_mat3DVec__[11] = 0;
            this.____motion_subTextContaineraf1_mat3DVec__[12] = 319;
            this.____motion_subTextContaineraf1_mat3DVec__[13] = 378.25;
            this.____motion_subTextContaineraf1_mat3DVec__[14] = -128;
            this.____motion_subTextContaineraf1_mat3DVec__[15] = 1;
            this.____motion_subTextContaineraf1_matArray__.push(new Matrix3D(this.____motion_subTextContaineraf1_mat3DVec__));
            this.__motion_subTextContaineraf1.addPropertyArray("matrix3D",this.____motion_subTextContaineraf1_matArray__);
            this.__animArray_subTextContaineraf1.push(this.__motion_subTextContaineraf1);
            this.__animFactory_subTextContaineraf1 = new AnimatorFactory3D(null,this.__animArray_subTextContaineraf1);
            this.__animFactory_subTextContaineraf1.addTargetInfo(this,"subTextContainer",0,true,0,true,null,-1);
         }
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame30() : *
      {
         stop();
      }
   }
}
