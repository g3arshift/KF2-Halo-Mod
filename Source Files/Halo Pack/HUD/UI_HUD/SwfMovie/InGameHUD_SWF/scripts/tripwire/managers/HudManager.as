package tripwire.managers
{
   import scaleform.clik.core.UIComponent;
   import flash.events.Event;
   import flash.geom.Point;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import tripwire.widgets.PlayerChatWidget;
   import tripwire.widgets.PlayerStatWidget;
   import tripwire.widgets.WeaponSelectWidget;
   import tripwire.widgets.VoipNotificationWidget;
   import tripwire.widgets.BossNameplateWidget;
   import tripwire.widgets.NonCriticalGameMessageWidget;
   import tripwire.widgets.ControllerWeaponSelectWidget;
   import tripwire.widgets.BossHealthBarWidget;
   import tripwire.Tools.TripLayout;
   import tripwire.controls.KillAlertMessage;
   import com.greensock.TimelineMax;
   import flash.display.BitmapData;
   import flash.utils.getDefinitionByName;
   import scaleform.clik.layout.LayoutData;
   import scaleform.clik.constants.LayoutMode;
   import scaleform.gfx.Extensions;
   import flash.display.StageScaleMode;
   import flash.display.StageAlign;
   import com.greensock.easing.Cubic;
   import flash.geom.PerspectiveProjection;
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import fl.motion.motion_internal;
   import flash.geom.Matrix3D;
   
   public class HudManager extends UIComponent
   {
      
      private static var _manager:tripwire.managers.HudManager;
       
      
      public var __animFactory_PlayerBackpackWidgetaf1:AnimatorFactory3D;
      
      public var __animArray_PlayerBackpackWidgetaf1:Array;
      
      public var ____motion_PlayerBackpackWidgetaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_PlayerBackpackWidgetaf1_matArray__:Array;
      
      public var __motion_PlayerBackpackWidgetaf1:MotionBase;
      
      public var __animFactory_BossNamePlateaf1:AnimatorFactory3D;
      
      public var __animArray_BossNamePlateaf1:Array;
      
      public var ____motion_BossNamePlateaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_BossNamePlateaf1_matArray__:Array;
      
      public var __motion_BossNamePlateaf1:MotionBase;
      
      public var PrimaryLayoutIndex:int = 2;
      
      public var SecondaryLayoutIndex:int = 1;
      
      public var ThirdLayoutIndex:int = 0;
      
      public var layoutID:String = "Main";
      
      public var WaveCompassWidget:UIComponent;
      
      public var ChatBoxWidget:PlayerChatWidget;
      
      public var PlayerStatWidgetMC:PlayerStatWidget;
      
      public var WeaponSelectContainer:WeaponSelectWidget;
      
      public var PriorityMsgWidget:UIComponent;
      
      public var PlayerBackpackWidget:UIComponent;
      
      public var voipWidget:VoipNotificationWidget;
      
      public var VoiceCommsWidget:UIComponent;
      
      public var LevelUpNotificationWidget:UIComponent;
      
      public var interactionMsgWidget:UIComponent;
      
      public var SpectatorInfoWidget:UIComponent;
      
      public var KickVoteWidget:UIComponent;
      
      public var BossNamePlate:BossNameplateWidget;
      
      public var NonCriticalMessageWidget:NonCriticalGameMessageWidget;
      
      public var MusicNotification:MusicNotificationWidget;
      
      public var RhythmCounter:RhythmCounterWidget;
      
      public var ControllerWeaponSelectContainer:ControllerWeaponSelectWidget;
      
      public var bossHealthBar:BossHealthBarWidget;
      
      public var barkNode:UIComponent;
      
      public var maxBarkCount:int = 8;
      
      public var barkOffset:Number = 0.1;
      
      public var sw:Number;
      
      public var sh:Number;
      
      public var sX:Number;
      
      public var sY:Number;
      
      public var newScale:Number = 1;
      
      protected var _bSpectating:Boolean = false;
      
      public const ORIGINAL_STAGE_WIDTH:Number = 1920;
      
      public const ORIGINAL_STAGE_HEIGHT:Number = 1080;
      
      public const ORIGINAL_FOV:Number = 32;
      
      public const BARK_SCALE:Number = 1.4;
      
      private var _HUDScale:Number = 1;
      
      public var layout:TripLayout;
      
      public var centerPoint:Point;
      
      private var _bConsoleBuild:Boolean;
      
      protected var BarkList:Vector.<KillAlertMessage>;
      
      public var barkTimeline:TimelineMax;
      
      public const imageReplaceSubstring:String = "<%x%>";
      
      public const assetSubstring:String = "_Asset";
      
      public const buttonIconWidth:int = 32;
      
      public const buttonIconHeight:int = 32;
      
      public const buttonIconBaseLine:int = 100;
      
      public var dPadLeftBitmapdata:BitmapData;
      
      public var dPadRightBitmapdata:BitmapData;
      
      public var dPadUpBitmapdata:BitmapData;
      
      public var dPadDownBitmapdata:BitmapData;
      
      public var aButtonBitmapdata:BitmapData;
      
      public var bButtonBitmapdata:BitmapData;
      
      public var xButtonBitmapdata:BitmapData;
      
      public var yButtonBitmapdata:BitmapData;
      
      public var l1Bitmapdata:BitmapData;
      
      public var l2Bitmapdata:BitmapData;
      
      public var l3Bitmapdata:BitmapData;
      
      public var r1Bitmapdata:BitmapData;
      
      public var r2Bitmapdata:BitmapData;
      
      public var r3Bitmapdata:BitmapData;
      
      public const controllerIconPrefix:String = "XboxTypeS_";
      
      public const dDownSubString:String = "DPad_Down";
      
      public const dLeftSubString:String = "DPad_Left";
      
      public const dRightSubString:String = "DPad_Right";
      
      public const dUpSubString:String = "DPad_Up";
      
      public const aButtonSubString:String = "XboxTypeS_A";
      
      public const bButtonSubString:String = "XboxTypeS_B";
      
      public const xButtonSubString:String = "XboxTypeS_X";
      
      public const yButtonSubString:String = "XboxTypeS_Y";
      
      public const l1SubString:String = "LeftShoulder";
      
      public const l2SubString:String = "LeftTrigger";
      
      public const l3SubString:String = "LeftThumbStick";
      
      public const r1SubString:String = "RightShoulder";
      
      public const r2SubString:String = "RightTrigger";
      
      public const r3SubString:String = "RightThumbStick";
      
      public var controllerIconObjects;
      
      public function HudManager()
      {
         this.BarkList = new Vector.<KillAlertMessage>();
         this.barkTimeline = new TimelineMax({
            "paused":true,
            "useFrames":true,
            "onComplete":this.clearBarkTimeline
         });
         this.controllerIconObjects = new Array();
         addFrameScript(0,this.frame1);
         super();
         this.SpectatorInfoWidget.visible = false;
         this.CreateBitMapData();
         _manager = this;
         addEventListener(Event.ADDED_TO_STAGE,this.__setPerspectiveProjection_);
         if(this.__animFactory_PlayerBackpackWidgetaf1 == null)
         {
            this.__animArray_PlayerBackpackWidgetaf1 = new Array();
            this.__motion_PlayerBackpackWidgetaf1 = new MotionBase();
            this.__motion_PlayerBackpackWidgetaf1.duration = 1;
            this.__motion_PlayerBackpackWidgetaf1.overrideTargetTransform();
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("alphaMultiplier",[0.88]);
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("visible",[true]);
            this.__motion_PlayerBackpackWidgetaf1.is3D = true;
            this.__motion_PlayerBackpackWidgetaf1.motion_internal::spanStart = 0;
            this.____motion_PlayerBackpackWidgetaf1_matArray__ = new Array();
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[0] = 1;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[1] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[2] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[3] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[4] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[5] = 1;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[6] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[7] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[8] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[9] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[10] = 1;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[11] = 0;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[12] = 1584.004639;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[13] = 824;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[14] = 0.021148;
            this.____motion_PlayerBackpackWidgetaf1_mat3DVec__[15] = 1;
            this.____motion_PlayerBackpackWidgetaf1_matArray__.push(new Matrix3D(this.____motion_PlayerBackpackWidgetaf1_mat3DVec__));
            this.__motion_PlayerBackpackWidgetaf1.addPropertyArray("matrix3D",this.____motion_PlayerBackpackWidgetaf1_matArray__);
            this.__animArray_PlayerBackpackWidgetaf1.push(this.__motion_PlayerBackpackWidgetaf1);
            this.__animFactory_PlayerBackpackWidgetaf1 = new AnimatorFactory3D(null,this.__animArray_PlayerBackpackWidgetaf1);
            this.__animFactory_PlayerBackpackWidgetaf1.sceneName = "Scene 1";
            this.__animFactory_PlayerBackpackWidgetaf1.addTargetInfo(this,"PlayerBackpackWidget",0,true,0,true,null,-1);
         }
         if(this.__animFactory_BossNamePlateaf1 == null)
         {
            this.__animArray_BossNamePlateaf1 = new Array();
            this.__motion_BossNamePlateaf1 = new MotionBase();
            this.__motion_BossNamePlateaf1.duration = 1;
            this.__motion_BossNamePlateaf1.overrideTargetTransform();
            this.__motion_BossNamePlateaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_BossNamePlateaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_BossNamePlateaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_BossNamePlateaf1.addPropertyArray("visible",[false]);
            this.__motion_BossNamePlateaf1.is3D = true;
            this.__motion_BossNamePlateaf1.motion_internal::spanStart = 0;
            this.____motion_BossNamePlateaf1_matArray__ = new Array();
            this.____motion_BossNamePlateaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_BossNamePlateaf1_mat3DVec__[0] = 0.75;
            this.____motion_BossNamePlateaf1_mat3DVec__[1] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[2] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[3] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[4] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[5] = 0.75;
            this.____motion_BossNamePlateaf1_mat3DVec__[6] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[7] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[8] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[9] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[10] = 1;
            this.____motion_BossNamePlateaf1_mat3DVec__[11] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[12] = 991.450012;
            this.____motion_BossNamePlateaf1_mat3DVec__[13] = 524.150024;
            this.____motion_BossNamePlateaf1_mat3DVec__[14] = 0;
            this.____motion_BossNamePlateaf1_mat3DVec__[15] = 1;
            this.____motion_BossNamePlateaf1_matArray__.push(new Matrix3D(this.____motion_BossNamePlateaf1_mat3DVec__));
            this.__motion_BossNamePlateaf1.addPropertyArray("matrix3D",this.____motion_BossNamePlateaf1_matArray__);
            this.__animArray_BossNamePlateaf1.push(this.__motion_BossNamePlateaf1);
            this.__animFactory_BossNamePlateaf1 = new AnimatorFactory3D(null,this.__animArray_BossNamePlateaf1);
            this.__animFactory_BossNamePlateaf1.sceneName = "Scene 1";
            this.__animFactory_BossNamePlateaf1.addTargetInfo(this,"BossNamePlate",0,true,0,true,null,-1);
         }
         this.__setProp_voipWidget_Scene1_VOIPList_0();
      }
      
      public static function get manager() : tripwire.managers.HudManager
      {
         return _manager;
      }
      
      public function __setPerspectiveProjection_(param1:Event) : void
      {
         root.transform.perspectiveProjection.fieldOfView = 32;
         root.transform.perspectiveProjection.projectionCenter = new Point(960,540);
      }
      
      public function CreateBitMapData() : void
      {
         this.dPadDownBitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.dDownSubString + this.assetSubstring) as Class)() as BitmapData;
         this.dPadLeftBitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.dLeftSubString + this.assetSubstring) as Class)() as BitmapData;
         this.dPadRightBitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.dRightSubString + this.assetSubstring) as Class)() as BitmapData;
         this.dPadUpBitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.dUpSubString + this.assetSubstring) as Class)() as BitmapData;
         this.aButtonBitmapdata = new (getDefinitionByName(this.aButtonSubString + this.assetSubstring) as Class)() as BitmapData;
         this.bButtonBitmapdata = new (getDefinitionByName(this.bButtonSubString + this.assetSubstring) as Class)() as BitmapData;
         this.xButtonBitmapdata = new (getDefinitionByName(this.xButtonSubString + this.assetSubstring) as Class)() as BitmapData;
         this.yButtonBitmapdata = new (getDefinitionByName(this.yButtonSubString + this.assetSubstring) as Class)() as BitmapData;
         this.l1Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.l1SubString + this.assetSubstring) as Class)() as BitmapData;
         this.l2Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.l2SubString + this.assetSubstring) as Class)() as BitmapData;
         this.l3Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.l3SubString + this.assetSubstring) as Class)() as BitmapData;
         this.r1Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.r1SubString + this.assetSubstring) as Class)() as BitmapData;
         this.r2Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.r2SubString + this.assetSubstring) as Class)() as BitmapData;
         this.r3Bitmapdata = new (getDefinitionByName(this.controllerIconPrefix + this.r3SubString + this.assetSubstring) as Class)() as BitmapData;
         this.controllerIconObjects.push({
            "subString":this.l1SubString,
            "image":this.l1Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.l2SubString,
            "image":this.l2Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.l3SubString,
            "image":this.l3Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.r1SubString,
            "image":this.r1Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.r2SubString,
            "image":this.r2Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.r3SubString,
            "image":this.r3Bitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.r3SubString
         });
         this.controllerIconObjects.push({
            "subString":this.dDownSubString,
            "image":this.dPadDownBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.dDownSubString
         });
         this.controllerIconObjects.push({
            "subString":this.dLeftSubString,
            "image":this.dPadLeftBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.dDownSubString
         });
         this.controllerIconObjects.push({
            "subString":this.dRightSubString,
            "image":this.dPadRightBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.dDownSubString
         });
         this.controllerIconObjects.push({
            "subString":this.dUpSubString,
            "image":this.dPadUpBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.dDownSubString
         });
         this.controllerIconObjects.push({
            "subString":this.aButtonSubString,
            "image":this.aButtonBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.bButtonSubString
         });
         this.controllerIconObjects.push({
            "subString":this.bButtonSubString,
            "image":this.bButtonBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.bButtonSubString
         });
         this.controllerIconObjects.push({
            "subString":this.xButtonSubString,
            "image":this.xButtonBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.bButtonSubString
         });
         this.controllerIconObjects.push({
            "subString":this.yButtonSubString,
            "image":this.yButtonBitmapdata,
            "baseLineY":this.buttonIconBaseLine,
            "width":40,
            "height":40,
            "id":this.bButtonSubString
         });
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function get bConsoleBuild() : Boolean
      {
         return this._bConsoleBuild;
      }
      
      public function set bConsoleBuild(param1:Boolean) : *
      {
         if(this._bConsoleBuild != param1)
         {
            this._bConsoleBuild = param1;
         }
      }
      
      public function set bSpectating(param1:Boolean) : void
      {
         this._bSpectating = param1;
         this.PlayerBackpackWidget.visible = !param1;
         this.PlayerStatWidgetMC.visible = !param1;
         if(this.SpectatorInfoWidget.visible)
         {
            this.SpectatorInfoWidget.visible = param1;
         }
         if(param1)
         {
            this.interactionMsgWidget.visible = false;
         }
      }
      
      public function set bossData(param1:Object) : void
      {
         this.WaveCompassWidget.visible = false;
         this.ChatBoxWidget.visible = false;
         this.PlayerStatWidgetMC.visible = false;
         this.WeaponSelectContainer.visible = false;
         if(this.ControllerWeaponSelectContainer)
         {
            this.ControllerWeaponSelectContainer.visible = false;
         }
         this.PriorityMsgWidget.visible = false;
         this.PlayerBackpackWidget.visible = false;
         this.voipWidget.visible = false;
         this.VoiceCommsWidget.visible = false;
         if(this.bossHealthBar)
         {
            this.bossHealthBar.visible = false;
         }
         this.LevelUpNotificationWidget.visible = false;
         this.interactionMsgWidget.visible = false;
         this.SpectatorInfoWidget.visible = false;
         this.KickVoteWidget.visible = false;
         this.NonCriticalMessageWidget.visible = false;
         this.MusicNotification.visible = false;
         this.BossNamePlate.setText(!!param1.bossName?param1.bossName:"",!!param1.subString?param1.subString:"");
      }
      
      public function hideBossNamePlate() : void
      {
         this.WaveCompassWidget.visible = true;
         this.ChatBoxWidget.visible = true;
         this.PlayerStatWidgetMC.visible = true;
         this.PlayerBackpackWidget.visible = true;
         this.voipWidget.visible = true;
         this.VoiceCommsWidget.visible = true;
         this.bSpectating = this._bSpectating;
         this.BossNamePlate.visible = false;
      }
      
      public function createLayout() : *
      {
         this.WaveCompassWidget.layoutData = new LayoutData(LayoutMode.ALIGN_LEFT,LayoutMode.ALIGN_TOP,16,16,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.BossNamePlate.layoutData = new LayoutData(LayoutMode.ALIGN_RIGHT,LayoutMode.ALIGN_BOTTOM,-8,-8,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.LevelUpNotificationWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_BOTTOM,0,-40,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.PlayerBackpackWidget.layoutData = new LayoutData(LayoutMode.ALIGN_RIGHT,LayoutMode.ALIGN_BOTTOM,-16,-16,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.KickVoteWidget.layoutData = new LayoutData(LayoutMode.ALIGN_RIGHT,LayoutMode.ALIGN_BOTTOM,-20,-256,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.PlayerStatWidgetMC.layoutData = new LayoutData(LayoutMode.ALIGN_LEFT,LayoutMode.ALIGN_BOTTOM,16,-16,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.ChatBoxWidget.layoutData = new LayoutData(LayoutMode.ALIGN_LEFT,LayoutMode.ALIGN_BOTTOM,24,-216,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.voipWidget.layoutData = new LayoutData(LayoutMode.ALIGN_LEFT,LayoutMode.ALIGN_TOP,16,16,"",this.ChatBoxWidget.name,this.SecondaryLayoutIndex,this.layoutID);
         this.PriorityMsgWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_CENTER,0,0,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.VoiceCommsWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_CENTER,0,0,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.MusicNotification.layoutData = new LayoutData(LayoutMode.ALIGN_RIGHT,LayoutMode.ALIGN_TOP,-32,32,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.barkNode.layoutData = new LayoutData(LayoutMode.ALIGN_RIGHT,LayoutMode.ALIGN_BOTTOM,-32,0,"",this.MusicNotification.name,this.SecondaryLayoutIndex,this.layoutID);
         this.NonCriticalMessageWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_BOTTOM,0,-32,"","",this.PrimaryLayoutIndex,this.layoutID);
         this.interactionMsgWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_BOTTOM,0,-128,"","",this.SecondaryLayoutIndex,this.layoutID);
         this.SpectatorInfoWidget.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_BOTTOM,0,-60,"","",this.ThirdLayoutIndex,this.layoutID);
         if(this.bossHealthBar)
         {
            this.bossHealthBar.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_TOP,0,0,"","",this.PrimaryLayoutIndex,this.layoutID);
            this.WeaponSelectContainer.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_TOP,0,0,"","",this.PrimaryLayoutIndex,this.layoutID);
            this.RhythmCounter.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_BOTTOM,0,16,"",this.bossHealthBar.name,this.SecondaryLayoutIndex,this.layoutID);
         }
         if(this.ControllerWeaponSelectContainer)
         {
            this.ControllerWeaponSelectContainer.layoutData = new LayoutData(LayoutMode.ALIGN_CENTER,LayoutMode.ALIGN_CENTER,0,0,"","",this.PrimaryLayoutIndex,this.layoutID);
         }
         this.layout = new TripLayout();
         this.layout.identifier = this.layoutID;
         this.layout.tiedToStageSize = true;
         this.layout.hidden = false;
         addChild(this.layout);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         Extensions.enabled = true;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.addEventListener(Event.RESIZE,this.handleStageResize,false,0,true);
         if(this.layout == null)
         {
            this.createLayout();
         }
         this.handleStageResize();
      }
      
      function showLocalizedMessage(param1:String) : void
      {
         if(this.NonCriticalMessageWidget)
         {
            this.NonCriticalMessageWidget.message = param1;
         }
      }
      
      public function set newBark(param1:Object) : void
      {
         var _loc2_:KillAlertMessage = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:KillAlertMessage = null;
         var _loc6_:int = 0;
         if(param1)
         {
            _loc2_ = new KillAlertMessage_MC() as KillAlertMessage;
            _loc3_ = 0;
            this.barkNode.addChild(_loc2_);
            this.scaleChild(_loc2_);
            if(param1.humanDeath)
            {
               _loc2_.scaleX = _loc2_.scaleX * this.BARK_SCALE;
               _loc2_.scaleY = _loc2_.scaleY * this.BARK_SCALE;
               _loc3_ = _loc2_.height * this.barkOffset;
            }
            this.barkTimeline.progress(1,false);
            while(_loc4_ < this.BarkList.length)
            {
               this.barkTimeline.to(this.BarkList[_loc4_],4,{
                  "y":"+=" + String(_loc2_.height + _loc3_),
                  "useFrames":true,
                  "ease":Cubic.easeOut
               },"-=4");
               _loc4_++;
            }
            this.barkTimeline.restart();
            this.BarkList.push(_loc2_);
            _loc2_.data = param1;
            _loc2_.addEventListener("onTweenComplete",this.removeUsedBark,false,0,true);
            if(this.BarkList.length > this.maxBarkCount)
            {
               _loc5_ = new KillAlertMessage_MC() as KillAlertMessage;
               _loc6_ = 0;
               while(_loc6_ < this.BarkList.length - this.maxBarkCount)
               {
                  _loc5_ = this.BarkList[_loc6_];
                  _loc5_.closeAnimation();
                  _loc6_++;
               }
            }
         }
      }
      
      public function removeUsedBark(param1:Event) : void
      {
         var _loc2_:KillAlertMessage = null;
         _loc2_ = this.BarkList.shift();
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener("onTweenComplete",this.removeUsedBark);
            this.barkNode.removeChild(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function clearBarkTimeline() : void
      {
         this.barkTimeline.clear();
      }
      
      public function handleStageResize(param1:Event = null) : void
      {
         this.sw = stage.stageWidth;
         this.sh = stage.stageHeight;
         this.sX = this.sw / this.ORIGINAL_STAGE_WIDTH;
         this.sY = this.sh / this.ORIGINAL_STAGE_HEIGHT;
         var _loc2_:PerspectiveProjection = new PerspectiveProjection();
         _loc2_.projectionCenter = new Point(this.sw / 2,this.sh / 2);
         _loc2_.fieldOfView = this.ORIGINAL_FOV;
         root.transform.perspectiveProjection = _loc2_;
         if(this.sX > this.sY)
         {
            this.newScale = this.sY;
         }
         else
         {
            this.newScale = this.sX;
         }
         if(this.newScale > 1)
         {
            this.newScale = 1;
         }
         this.UpdateElementScales();
         this.NonCriticalMessageWidget.message = "";
         TweenMax.to(this.PlayerStatWidgetMC,3,{
            "onComplete":this.start3d,
            "useFrames":true
         });
      }
      
      public function set HUDScale(param1:Number) : void
      {
         if(this._HUDScale != param1)
         {
            this._HUDScale = param1;
            this.UpdateElementScales();
         }
      }
      
      public function set WeaponSelectY(param1:Number) : void
      {
         this.WeaponSelectContainer.y = param1;
      }
      
      public function UpdateElementScales() : void
      {
         this.scaleChild(this.WeaponSelectContainer);
         this.scaleChild(this.ControllerWeaponSelectContainer);
         this.scaleChild(this.ChatBoxWidget);
         this.scaleChild(this.voipWidget);
         this.scaleChild(this.WaveCompassWidget);
         this.scaleChild(this.PlayerStatWidgetMC);
         this.scaleChild(this.VoiceCommsWidget);
         this.scaleChild(this.PlayerBackpackWidget);
         this.scaleChild(this.PriorityMsgWidget);
         this.scaleChild(this.interactionMsgWidget);
         this.scaleChild(this.LevelUpNotificationWidget);
         this.scaleChild(this.SpectatorInfoWidget);
         this.scaleChild(this.MusicNotification);
         this.scaleChild(this.NonCriticalMessageWidget);
         this.scaleChild(this.KickVoteWidget);
         this.scaleChild(this.BossNamePlate);
         this.scaleChild(this.RhythmCounter);
         this.scaleChild(this.bossHealthBar);
      }
      
      public function scaleChild(param1:UIComponent) : void
      {
         param1.scaleX = this.newScale * this._HUDScale;
         param1.scaleY = this.newScale * this._HUDScale;
      }
      
      public function start3d() : void
      {
         this.apply3d(this.bossHealthBar,0,0,288,"top","center");
         this.apply3d(this.WeaponSelectContainer,0,0,0,"center","center");
         this.apply3d(this.ControllerWeaponSelectContainer,0,0,0,"center","center");
         this.apply3d(this.PlayerStatWidgetMC,0,-24,0,"bottom","left");
         this.apply3d(this.PlayerBackpackWidget,0,24,0,"bottom","right");
         this.apply3d(this.KickVoteWidget,0,24,0,"bottom","right");
         this.apply3d(this.BossNamePlate,0,0,0,"bottom","right");
         this.apply3d(this.WaveCompassWidget,0,-24,0,"top","left");
         this.apply3d(this.SpectatorInfoWidget,0,0,288,"center","center");
         this.apply3d(this.LevelUpNotificationWidget,0,0,288,"center","center");
         this.apply3d(this.interactionMsgWidget,0,0,288,"center","center");
         this.apply3d(this.ChatBoxWidget,0,-24,0,"top","left");
         this.apply3d(this.voipWidget,0,-24,0,"top","left");
         this.apply3d(this.barkNode,0,24,0,"bottom","right");
         this.apply3d(this.PriorityMsgWidget,0,0,288,"center","center");
         this.apply3d(this.VoiceCommsWidget,0,0,288,"center","center");
         this.apply3d(this.NonCriticalMessageWidget,0,0,0,"center","center");
         this.apply3d(this.MusicNotification,0,24,0,"top","right");
         this.apply3d(this.RhythmCounter,0,0,288,"top","center");
      }
      
      public function apply3d(param1:UIComponent, param2:Number, param3:Number, param4:Number, param5:String = "top", param6:String = "left") : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc13_:Sprite = null;
         var _loc11_:* = param1.x;
         var _loc12_:* = param1.y;
         if(param5 == "top")
         {
            _loc8_ = param1.y;
            _loc10_ = 0;
         }
         else if(param5 == "bottom")
         {
            _loc8_ = param1.y + param1.height;
            _loc10_ = -param1.height;
         }
         else if(param5 == "center")
         {
            _loc8_ = param1.y + param1.height / 2;
            _loc10_ = -(param1.height / 2);
         }
         if(param6 == "left")
         {
            _loc7_ = param1.x;
            _loc9_ = 0;
         }
         else if(param6 == "right")
         {
            _loc7_ = param1.x + param1.width;
            _loc9_ = -param1.width;
         }
         else if(param6 == "center")
         {
            _loc7_ = param1.x + param1.width / 2;
            _loc9_ = -(param1.width / 2);
         }
         else
         {
            _loc7_ = param1.x;
            _loc8_ = param1.y;
         }
         if(this.getChildByName("square" + param1.name) != null)
         {
            this.addChild(param1);
            this.removeChild(this.getChildByName("square" + param1.name));
            _loc13_ = null;
         }
         _loc13_ = new Sprite();
         _loc13_.name = "square" + param1.name;
         this.addChild(_loc13_);
         _loc13_.x = _loc7_;
         _loc13_.y = _loc8_;
         _loc13_.rotationX = param2;
         _loc13_.rotationY = param3;
         _loc13_.z = param4;
         TweenMax.to(this,1,{
            "onComplete":this.setSprite,
            "onCompleteParams":[_loc13_,param1,_loc9_,_loc10_],
            "useFrames":true
         });
      }
      
      public function setSprite(param1:Sprite, param2:UIComponent, param3:Number, param4:Number) : void
      {
         param1.addChild(param2);
         param2.x = param3;
         param2.y = param4;
      }
      
      function __setProp_voipWidget_Scene1_VOIPList_0() : *
      {
         try
         {
            this.voipWidget["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.voipWidget.enabled = true;
         this.voipWidget.enableInitCallback = true;
         this.voipWidget.visible = true;
         try
         {
            this.voipWidget["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {
      }
   }
}
