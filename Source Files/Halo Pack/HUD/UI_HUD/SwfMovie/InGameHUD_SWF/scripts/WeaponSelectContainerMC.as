package
{
   import tripwire.widgets.WeaponSelectWidget;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import adobe.utils.*;
   import flash.geom.Matrix3D;
   
   public dynamic class WeaponSelectContainerMC extends WeaponSelectWidget
   {
       
      
      public var __animFactory_WeaponCategoryContainer3af1:AnimatorFactory3D;
      
      public var __animArray_WeaponCategoryContainer3af1:Array;
      
      public var ____motion_WeaponCategoryContainer3af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_WeaponCategoryContainer3af1_matArray__:Array;
      
      public var __motion_WeaponCategoryContainer3af1:MotionBase;
      
      public var __animFactory_WeaponCategoryContainer2af1:AnimatorFactory3D;
      
      public var __animArray_WeaponCategoryContainer2af1:Array;
      
      public var ____motion_WeaponCategoryContainer2af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_WeaponCategoryContainer2af1_matArray__:Array;
      
      public var __motion_WeaponCategoryContainer2af1:MotionBase;
      
      public var __animFactory_WeaponCategoryContainer1af1:AnimatorFactory3D;
      
      public var __animArray_WeaponCategoryContainer1af1:Array;
      
      public var ____motion_WeaponCategoryContainer1af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_WeaponCategoryContainer1af1_matArray__:Array;
      
      public var __motion_WeaponCategoryContainer1af1:MotionBase;
      
      public var __animFactory_WeaponCategoryContainer0af1:AnimatorFactory3D;
      
      public var __animArray_WeaponCategoryContainer0af1:Array;
      
      public var ____motion_WeaponCategoryContainer0af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_WeaponCategoryContainer0af1_matArray__:Array;
      
      public var __motion_WeaponCategoryContainer0af1:MotionBase;
      
      public function WeaponSelectContainerMC()
      {
         super();
         addFrameScript(0,this.frame1);
         if(this.__animFactory_WeaponCategoryContainer3af1 == null)
         {
            this.__animArray_WeaponCategoryContainer3af1 = new Array();
            this.__motion_WeaponCategoryContainer3af1 = new MotionBase();
            this.__motion_WeaponCategoryContainer3af1.duration = 1;
            this.__motion_WeaponCategoryContainer3af1.overrideTargetTransform();
            this.__motion_WeaponCategoryContainer3af1.addPropertyArray("blendMode",["layer"]);
            this.__motion_WeaponCategoryContainer3af1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponCategoryContainer3af1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponCategoryContainer3af1.addPropertyArray("visible",[true]);
            this.__motion_WeaponCategoryContainer3af1.is3D = true;
            this.__motion_WeaponCategoryContainer3af1.motion_internal::spanStart = 0;
            this.____motion_WeaponCategoryContainer3af1_matArray__ = new Array();
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[0] = 0.961262;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[1] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[2] = -0.275637;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[3] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[4] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[5] = 1;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[6] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[7] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[8] = 0.275637;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[9] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[10] = 0.961262;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[11] = 0;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[12] = 1230.297119;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[13] = 32;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[14] = 274.152954;
            this.____motion_WeaponCategoryContainer3af1_mat3DVec__[15] = 1;
            this.____motion_WeaponCategoryContainer3af1_matArray__.push(new Matrix3D(this.____motion_WeaponCategoryContainer3af1_mat3DVec__));
            this.__motion_WeaponCategoryContainer3af1.addPropertyArray("matrix3D",this.____motion_WeaponCategoryContainer3af1_matArray__);
            this.__animArray_WeaponCategoryContainer3af1.push(this.__motion_WeaponCategoryContainer3af1);
            this.__animFactory_WeaponCategoryContainer3af1 = new AnimatorFactory3D(null,this.__animArray_WeaponCategoryContainer3af1);
            this.__animFactory_WeaponCategoryContainer3af1.addTargetInfo(this,"WeaponCategoryContainer3",0,true,0,true,null,-1);
         }
         if(this.__animFactory_WeaponCategoryContainer2af1 == null)
         {
            this.__animArray_WeaponCategoryContainer2af1 = new Array();
            this.__motion_WeaponCategoryContainer2af1 = new MotionBase();
            this.__motion_WeaponCategoryContainer2af1.duration = 1;
            this.__motion_WeaponCategoryContainer2af1.overrideTargetTransform();
            this.__motion_WeaponCategoryContainer2af1.addPropertyArray("blendMode",["layer"]);
            this.__motion_WeaponCategoryContainer2af1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponCategoryContainer2af1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponCategoryContainer2af1.addPropertyArray("visible",[true]);
            this.__motion_WeaponCategoryContainer2af1.is3D = true;
            this.__motion_WeaponCategoryContainer2af1.motion_internal::spanStart = 0;
            this.____motion_WeaponCategoryContainer2af1_matArray__ = new Array();
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[0] = 1;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[1] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[2] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[3] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[4] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[5] = 1;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[6] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[7] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[8] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[9] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[10] = 1;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[11] = 0;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[12] = 973;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[13] = 32;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[14] = 288;
            this.____motion_WeaponCategoryContainer2af1_mat3DVec__[15] = 1;
            this.____motion_WeaponCategoryContainer2af1_matArray__.push(new Matrix3D(this.____motion_WeaponCategoryContainer2af1_mat3DVec__));
            this.__motion_WeaponCategoryContainer2af1.addPropertyArray("matrix3D",this.____motion_WeaponCategoryContainer2af1_matArray__);
            this.__animArray_WeaponCategoryContainer2af1.push(this.__motion_WeaponCategoryContainer2af1);
            this.__animFactory_WeaponCategoryContainer2af1 = new AnimatorFactory3D(null,this.__animArray_WeaponCategoryContainer2af1);
            this.__animFactory_WeaponCategoryContainer2af1.addTargetInfo(this,"WeaponCategoryContainer2",0,true,0,true,null,-1);
         }
         if(this.__animFactory_WeaponCategoryContainer1af1 == null)
         {
            this.__animArray_WeaponCategoryContainer1af1 = new Array();
            this.__motion_WeaponCategoryContainer1af1 = new MotionBase();
            this.__motion_WeaponCategoryContainer1af1.duration = 1;
            this.__motion_WeaponCategoryContainer1af1.overrideTargetTransform();
            this.__motion_WeaponCategoryContainer1af1.addPropertyArray("blendMode",["layer"]);
            this.__motion_WeaponCategoryContainer1af1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponCategoryContainer1af1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponCategoryContainer1af1.addPropertyArray("visible",[true]);
            this.__motion_WeaponCategoryContainer1af1.is3D = true;
            this.__motion_WeaponCategoryContainer1af1.motion_internal::spanStart = 0;
            this.____motion_WeaponCategoryContainer1af1_matArray__ = new Array();
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[0] = 1;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[1] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[2] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[3] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[4] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[5] = 1;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[6] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[7] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[8] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[9] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[10] = 1;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[11] = 0;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[12] = 717;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[13] = 32;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[14] = 288;
            this.____motion_WeaponCategoryContainer1af1_mat3DVec__[15] = 1;
            this.____motion_WeaponCategoryContainer1af1_matArray__.push(new Matrix3D(this.____motion_WeaponCategoryContainer1af1_mat3DVec__));
            this.__motion_WeaponCategoryContainer1af1.addPropertyArray("matrix3D",this.____motion_WeaponCategoryContainer1af1_matArray__);
            this.__animArray_WeaponCategoryContainer1af1.push(this.__motion_WeaponCategoryContainer1af1);
            this.__animFactory_WeaponCategoryContainer1af1 = new AnimatorFactory3D(null,this.__animArray_WeaponCategoryContainer1af1);
            this.__animFactory_WeaponCategoryContainer1af1.addTargetInfo(this,"WeaponCategoryContainer1",0,true,0,true,null,-1);
         }
         if(this.__animFactory_WeaponCategoryContainer0af1 == null)
         {
            this.__animArray_WeaponCategoryContainer0af1 = new Array();
            this.__motion_WeaponCategoryContainer0af1 = new MotionBase();
            this.__motion_WeaponCategoryContainer0af1.duration = 1;
            this.__motion_WeaponCategoryContainer0af1.overrideTargetTransform();
            this.__motion_WeaponCategoryContainer0af1.addPropertyArray("blendMode",["layer"]);
            this.__motion_WeaponCategoryContainer0af1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_WeaponCategoryContainer0af1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_WeaponCategoryContainer0af1.addPropertyArray("visible",[true]);
            this.__motion_WeaponCategoryContainer0af1.is3D = true;
            this.__motion_WeaponCategoryContainer0af1.motion_internal::spanStart = 0;
            this.____motion_WeaponCategoryContainer0af1_matArray__ = new Array();
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[0] = 0.961262;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[1] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[2] = 0.275637;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[3] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[4] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[5] = 1;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[6] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[7] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[8] = -0.275637;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[9] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[10] = 0.961262;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[11] = 0;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[12] = 469;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[13] = 32;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[14] = 208;
            this.____motion_WeaponCategoryContainer0af1_mat3DVec__[15] = 1;
            this.____motion_WeaponCategoryContainer0af1_matArray__.push(new Matrix3D(this.____motion_WeaponCategoryContainer0af1_mat3DVec__));
            this.__motion_WeaponCategoryContainer0af1.addPropertyArray("matrix3D",this.____motion_WeaponCategoryContainer0af1_matArray__);
            this.__animArray_WeaponCategoryContainer0af1.push(this.__motion_WeaponCategoryContainer0af1);
            this.__animFactory_WeaponCategoryContainer0af1 = new AnimatorFactory3D(null,this.__animArray_WeaponCategoryContainer0af1);
            this.__animFactory_WeaponCategoryContainer0af1.addTargetInfo(this,"WeaponCategoryContainer0",0,true,0,true,null,-1);
         }
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
