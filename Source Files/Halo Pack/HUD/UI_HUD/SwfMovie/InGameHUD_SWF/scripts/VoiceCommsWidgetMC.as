package
{
   import tripwire.widgets.VoiceCommsWidget;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import adobe.utils.*;
   import flash.geom.Matrix3D;
   
   public dynamic class VoiceCommsWidgetMC extends VoiceCommsWidget
   {
       
      
      public var __animFactory_dragBGaf1:AnimatorFactory3D;
      
      public var __animArray_dragBGaf1:Array;
      
      public var ____motion_dragBGaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_dragBGaf1_matArray__:Array;
      
      public var __motion_dragBGaf1:MotionBase;
      
      public var __animFactory_ballAaf1:AnimatorFactory3D;
      
      public var __animArray_ballAaf1:Array;
      
      public var ____motion_ballAaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_ballAaf1_matArray__:Array;
      
      public var __motion_ballAaf1:MotionBase;
      
      public function VoiceCommsWidgetMC()
      {
         super();
         if(this.__animFactory_dragBGaf1 == null)
         {
            this.__animArray_dragBGaf1 = new Array();
            this.__motion_dragBGaf1 = new MotionBase();
            this.__motion_dragBGaf1.duration = 1;
            this.__motion_dragBGaf1.overrideTargetTransform();
            this.__motion_dragBGaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_dragBGaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_dragBGaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_dragBGaf1.addPropertyArray("visible",[true]);
            this.__motion_dragBGaf1.is3D = true;
            this.__motion_dragBGaf1.motion_internal::spanStart = 0;
            this.____motion_dragBGaf1_matArray__ = new Array();
            this.____motion_dragBGaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_dragBGaf1_mat3DVec__[0] = 0.480011;
            this.____motion_dragBGaf1_mat3DVec__[1] = 0;
            this.____motion_dragBGaf1_mat3DVec__[2] = 0;
            this.____motion_dragBGaf1_mat3DVec__[3] = 0;
            this.____motion_dragBGaf1_mat3DVec__[4] = 0;
            this.____motion_dragBGaf1_mat3DVec__[5] = 1.199951;
            this.____motion_dragBGaf1_mat3DVec__[6] = 0;
            this.____motion_dragBGaf1_mat3DVec__[7] = 0;
            this.____motion_dragBGaf1_mat3DVec__[8] = 0;
            this.____motion_dragBGaf1_mat3DVec__[9] = 0;
            this.____motion_dragBGaf1_mat3DVec__[10] = 1;
            this.____motion_dragBGaf1_mat3DVec__[11] = 0;
            this.____motion_dragBGaf1_mat3DVec__[12] = 424;
            this.____motion_dragBGaf1_mat3DVec__[13] = 72.050003;
            this.____motion_dragBGaf1_mat3DVec__[14] = 0;
            this.____motion_dragBGaf1_mat3DVec__[15] = 1;
            this.____motion_dragBGaf1_matArray__.push(new Matrix3D(this.____motion_dragBGaf1_mat3DVec__));
            this.__motion_dragBGaf1.addPropertyArray("matrix3D",this.____motion_dragBGaf1_matArray__);
            this.__animArray_dragBGaf1.push(this.__motion_dragBGaf1);
            this.__animFactory_dragBGaf1 = new AnimatorFactory3D(null,this.__animArray_dragBGaf1);
            this.__animFactory_dragBGaf1.addTargetInfo(this,"dragBG",0,true,0,true,null,-1);
         }
         if(this.__animFactory_ballAaf1 == null)
         {
            this.__animArray_ballAaf1 = new Array();
            this.__motion_ballAaf1 = new MotionBase();
            this.__motion_ballAaf1.duration = 1;
            this.__motion_ballAaf1.overrideTargetTransform();
            this.__motion_ballAaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_ballAaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_ballAaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_ballAaf1.addPropertyArray("visible",[true]);
            this.__motion_ballAaf1.is3D = true;
            this.__motion_ballAaf1.motion_internal::spanStart = 0;
            this.____motion_ballAaf1_matArray__ = new Array();
            this.____motion_ballAaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_ballAaf1_mat3DVec__[0] = 1;
            this.____motion_ballAaf1_mat3DVec__[1] = 0;
            this.____motion_ballAaf1_mat3DVec__[2] = 0;
            this.____motion_ballAaf1_mat3DVec__[3] = 0;
            this.____motion_ballAaf1_mat3DVec__[4] = 0;
            this.____motion_ballAaf1_mat3DVec__[5] = 1;
            this.____motion_ballAaf1_mat3DVec__[6] = 0;
            this.____motion_ballAaf1_mat3DVec__[7] = 0;
            this.____motion_ballAaf1_mat3DVec__[8] = 0;
            this.____motion_ballAaf1_mat3DVec__[9] = 0;
            this.____motion_ballAaf1_mat3DVec__[10] = 1;
            this.____motion_ballAaf1_mat3DVec__[11] = 0;
            this.____motion_ballAaf1_mat3DVec__[12] = 506.350006;
            this.____motion_ballAaf1_mat3DVec__[13] = 152;
            this.____motion_ballAaf1_mat3DVec__[14] = 0;
            this.____motion_ballAaf1_mat3DVec__[15] = 1;
            this.____motion_ballAaf1_matArray__.push(new Matrix3D(this.____motion_ballAaf1_mat3DVec__));
            this.__motion_ballAaf1.addPropertyArray("matrix3D",this.____motion_ballAaf1_matArray__);
            this.__animArray_ballAaf1.push(this.__motion_ballAaf1);
            this.__animFactory_ballAaf1 = new AnimatorFactory3D(null,this.__animArray_ballAaf1);
            this.__animFactory_ballAaf1.addTargetInfo(this,"ballA",0,true,0,true,null,-1);
         }
      }
   }
}
