package tripwire.controls.voiceComms
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.controls.UILoader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   import tripwire.managers.HudManager;
   
   public class VoiceCommsOptionRenderer extends UIComponent
   {
       
      
      public var bActive:Boolean = false;
      
      public var textField:TextField;
      
      public var iconLoader:UILoader;
      
      public var itemIndex:int = -1;
      
      public var initialX:Number = 0;
      
      public var initialWidth:Number = 0;
      
      public var xMod:Number = 1;
      
      public var SelectHighlight:MovieClip;
      
      public var BG:MovieClip;
      
      public var Bumper:MovieClip;
      
      public var Scanlines:MovieClip;
      
      public var HighlightBG:MovieClip;
      
      public function VoiceCommsOptionRenderer()
      {
         super();
         stage.addEventListener("PopoutItems",this.popoutItem);
         this.textField.visible = false;
         this.iconLoader.visible = false;
         this.HighlightBG.visible = false;
         this.SelectHighlight.visible = false;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            this.initialX = this.x;
            this.initialWidth = this.width;
            if(this.initialX > 500)
            {
               this.xMod = -1;
            }
            this.textField.text = !!param1.text?param1.text:"";
            if(param1.iconPath && param1.iconPath != "")
            {
               this.iconLoader.source = param1.iconPath;
            }
         }
         else
         {
            this.textField.text = "";
         }
         visible = this.textField.text != "";
      }
      
      public function get text() : String
      {
         if(this.textField.text != null && this.textField.text != "")
         {
            return this.textField.text;
         }
         return "";
      }
      
      public function activateItem() : void
      {
         if(visible)
         {
            this.bActive = true;
            this.HighlightBG.visible = true;
            TweenMax.to(this,2,{
               "z":-48,
               "x":this.initialX + this.xMod * 8,
               "useFrames":true,
               "ease":Cubic.easeOut
            });
         }
      }
      
      public function deactivateItem() : void
      {
         if(visible)
         {
            this.bActive = false;
            this.HighlightBG.visible = false;
            TweenMax.to(this,2,{
               "z":0,
               "x":this.initialX,
               "delay":0,
               "useFrames":true,
               "ease":Cubic.easeIn
            });
         }
      }
      
      public function selectActiveItem() : void
      {
         if(!visible)
         {
         }
      }
      
      public function get bManagerConsoleBuild() : Boolean
      {
         if(HudManager.manager != null)
         {
            return HudManager.manager.bConsoleBuild;
         }
         return false;
      }
      
      protected function popoutItem(param1:Event) : void
      {
         stage.removeEventListener("PopoutItems",this.popoutItem);
         stage.addEventListener("PopinItems",this.popinItem);
         if(this.bManagerConsoleBuild)
         {
            this.Bumper.x = this.xMod * -400;
            this.textField.visible = true;
            this.iconLoader.visible = true;
            this.BG.scaleX = this.HighlightBG.scaleX = this.SelectHighlight.scaleX = this.Scanlines.scaleX = 1;
         }
         if(!this.bManagerConsoleBuild)
         {
            TweenMax.killTweensOf(this.textField);
            TweenMax.killTweensOf(this.iconLoader);
            TweenMax.fromTo(this.Bumper,2,{"x":this.xMod * -48},{
               "x":this.xMod * -400,
               "delay":2,
               "useFrames":true,
               "ease":Cubic.easeOut
            });
            TweenMax.allFromTo([this.BG,this.HighlightBG,this.SelectHighlight,this.Scanlines],2,{"scaleX":0.12},{
               "scaleX":1,
               "delay":2,
               "useFrames":true,
               "ease":Cubic.easeOut
            });
            TweenMax.allFromTo([this.textField,this.iconLoader],2,{"autoAlpha":0},{
               "autoAlpha":1,
               "delay":4,
               "useFrames":true,
               "ease":Cubic.easeOut
            });
         }
      }
      
      protected function popinItem(param1:Event) : void
      {
         stage.removeEventListener("PopinItems",this.popinItem);
         stage.addEventListener("PopoutItems",this.popoutItem);
         if(!this.bManagerConsoleBuild)
         {
            TweenMax.killTweensOf(this.textField);
            TweenMax.killTweensOf(this.iconLoader);
            TweenMax.allTo([this.textField,this.iconLoader],2,{
               "alpha":0,
               "visible":false,
               "useFrames":true,
               "ease":Cubic.easeIn
            });
            TweenMax.allFromTo([this.BG,this.HighlightBG,this.SelectHighlight,this.Scanlines],2,{"scaleX":1},{
               "scaleX":0.12,
               "delay":2,
               "useFrames":true,
               "ease":Cubic.easeIn
            });
            TweenMax.fromTo(this.Bumper,2,{"x":this.xMod * -400},{
               "x":this.xMod * -48,
               "delay":2,
               "useFrames":true,
               "ease":Cubic.easeIn
            });
         }
      }
   }
}
