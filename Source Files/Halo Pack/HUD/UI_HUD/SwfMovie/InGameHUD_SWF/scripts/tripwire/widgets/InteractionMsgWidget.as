package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import com.greensock.TimelineMax;
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;
   import flash.text.TextFieldAutoSize;
   import tripwire.managers.HudManager;
   import com.greensock.easing.Circ;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   
   public class InteractionMsgWidget extends UIComponent
   {
       
      
      public var hitbox:MovieClip;
      
      public var bigButtonText:TextField;
      
      public var buttonText:TextField;
      
      public var textField:TextField;
      
      public var Scanlines:MovieClip;
      
      public var BG:MovieClip;
      
      public var currentMainString:String;
      
      public var currentSubString:String;
      
      public var tempString:String;
      
      public var mainInteractionString:String;
      
      public var buttonString:String;
      
      public var holdString:String;
      
      public var tapString:String;
      
      public var subInteractionString:String;
      
      public var bIsHold:Boolean;
      
      public var introTimeline:TimelineMax;
      
      public var outroTimeline:TimelineMax;
      
      public var BGTargetTweenTime:int = 3;
      
      public const BGFullTweenTime:int = 3;
      
      public const BGTransitionTweenTime:int = 6;
      
      public var InteractionStartZ:Number;
      
      public const ADJUST_X:int = 32;
      
      public const OFFSET_Z:int = 128;
      
      public var BGTargetWidth:int = 16;
      
      public var BGTargetHeight:int = 48;
      
      public const BGStartWidth:int = 16;
      
      public const BGStartHeight:int = 48;
      
      public const BGMaxHeight:int = 80;
      
      public const TARGET_ALPHA:Number = 0.88;
      
      public const BRACKET_OFFSET_X:int = 6;
      
      public const BIGBUTTON_OFFSET_X:int = 24;
      
      public function InteractionMsgWidget()
      {
         this.introTimeline = new TimelineMax({
            "paused":true,
            "useFrames":true
         });
         this.outroTimeline = new TimelineMax({
            "paused":true,
            "useFrames":true
         });
         super();
         _enableInitCallback = true;
         visible = false;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         this.InteractionStartZ = this.z;
         alpha = 0;
         visible = false;
         super.addedToStage(param1);
         TextFieldEx.setVerticalAlign(this.textField,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.buttonText,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.bigButtonText,TextFieldEx.VALIGN_CENTER);
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.buttonText.autoSize = TextFieldAutoSize.RIGHT;
         this.bigButtonText.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function set interactionMessageData(param1:Object) : void
      {
         if(param1)
         {
            this.mainInteractionString = !!param1.message?param1.message:"";
            this.subInteractionString = !!param1.holdMessage?param1.holdMessage:"";
            this.buttonString = !!param1.buttonName?param1.buttonName:"";
            this.holdString = !!param1.holdString?param1.holdString:"";
            this.tapString = !!param1.tapString?param1.tapString:"";
            this.bIsHold = !!param1.bHoldCommand?Boolean(param1.bHoldCommand):false;
            this.displayInteractionMessage();
         }
      }
      
      public function showInteractionMessage(param1:String = "", param2:String = "") : void
      {
      }
      
      public function displayInteractionMessage() : void
      {
         if(this.textField.alpha > 0 && this.mainInteractionString == this.currentMainString && this.subInteractionString == this.currentSubString)
         {
            this.textField.alpha = 1;
            this.buttonText.alpha = 1;
            this.bigButtonText.alpha = 1;
         }
         else
         {
            this.z = visible == true?Number(this.InteractionStartZ):Number(this.InteractionStartZ + this.OFFSET_Z);
            this.BGTargetTweenTime = this.textField.alpha > 0?int(this.BGTransitionTweenTime):int(this.BGFullTweenTime);
            this.textField.alpha = 0;
            this.buttonText.alpha = 0;
            this.bigButtonText.alpha = 0;
            this.assignVals();
         }
      }
      
      public function assignVals() : *
      {
         var _loc1_:Number = this.hitbox.width;
         this.buttonText.width = 0;
         this.textField.width = 0;
         this.bigButtonText.width = 0;
         this.currentMainString = this.mainInteractionString;
         this.currentSubString = this.subInteractionString;
         this.buttonText.text = "";
         this.bigButtonText.text = "";
         if(this.buttonString != "")
         {
            this.buttonText.text = "〘 " + this.buttonString + " 〙";
            if(this.bIsHold)
            {
               this.buttonText.text = this.mainInteractionString == ""?"〘 " + this.holdString + " " + this.buttonString + " 〙":" " + " " + this.tapString + "\n " + " " + this.holdString;
               this.bigButtonText.text = this.mainInteractionString == ""?"":"〘 " + this.buttonString + " 〙";
            }
         }
         if(this.mainInteractionString == "")
         {
            this.textField.text = this.subInteractionString;
         }
         if(this.mainInteractionString != "")
         {
            this.textField.text = this.subInteractionString == ""?this.mainInteractionString:" " + " " + this.mainInteractionString + "\n " + " " + this.subInteractionString;
         }
         TextFieldEx.setImageSubstitutions(this.buttonText,HudManager.manager.controllerIconObjects);
         if(this.bigButtonText.text != "")
         {
            TextFieldEx.setImageSubstitutions(this.bigButtonText,HudManager.manager.controllerIconObjects);
         }
         _loc1_ = _loc1_ - (this.textField.width + this.buttonText.width + this.bigButtonText.width);
         this.BGTargetHeight = this.textField.numLines > 1?int(this.BGMaxHeight):int(this.BGStartHeight);
         this.BGTargetWidth = this.buttonText.width + this.textField.width + this.ADJUST_X;
         this.BGTargetWidth = this.BGTargetWidth + (this.bigButtonText.text == ""?0:this.bigButtonText.width - this.BIGBUTTON_OFFSET_X);
         this.bigButtonText.x = _loc1_ / 2;
         this.buttonText.x = this.bigButtonText.text == ""?Number(this.bigButtonText.x - this.BRACKET_OFFSET_X):Number(this.bigButtonText.x + this.bigButtonText.width - this.BIGBUTTON_OFFSET_X);
         this.textField.x = this.buttonText.x + this.buttonText.width;
         this.textField.x = this.textField.x + (this.buttonString == ""?this.BRACKET_OFFSET_X:0);
         this.makeIntroTimeline();
      }
      
      public function makeIntroTimeline() : void
      {
         this.introTimeline.stop();
         this.outroTimeline.stop();
         this.introTimeline.clear();
         this.introTimeline.set(this,{"visible":true});
         this.introTimeline.to(this,3,{
            "z":this.InteractionStartZ,
            "alpha":this.TARGET_ALPHA,
            "ease":Circ.easeIn
         });
         this.introTimeline.append(TweenMax.allTo([this.BG,this.Scanlines],this.BGTargetTweenTime,{
            "width":this.BGTargetWidth,
            "height":this.BGTargetHeight,
            "ease":Expo.easeOut
         }));
         this.introTimeline.append(TweenMax.allTo([this.textField,this.buttonText,this.bigButtonText],3,{
            "alpha":1,
            "ease":Circ.easeOut
         }));
         this.introTimeline.restart();
      }
      
      public function makeOutroTimeline() : void
      {
         this.introTimeline.stop();
         this.outroTimeline.stop();
         this.outroTimeline.clear();
         this.outroTimeline.append(TweenMax.allTo([this.textField,this.buttonText,this.bigButtonText],3,{
            "alpha":0,
            "ease":Circ.easeOut
         }));
         this.outroTimeline.append(TweenMax.allTo([this.BG,this.Scanlines],this.BGFullTweenTime,{
            "width":this.BGStartWidth,
            "height":this.BGStartHeight,
            "ease":Expo.easeOut
         }));
         this.outroTimeline.to(this,3,{
            "z":this.InteractionStartZ + this.OFFSET_Z,
            "alpha":0,
            "visible":false,
            "ease":Circ.easeOut
         });
         this.outroTimeline.restart();
      }
      
      public function outInteractionMessage() : void
      {
         if(visible)
         {
            this.makeOutroTimeline();
         }
      }
   }
}
