package tripwire.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import com.greensock.TimelineMax;
   import fl.motion.Color;
   import flash.events.Event;
   import flash.text.TextLineMetrics;
   import com.greensock.TweenMax;
   import com.greensock.easing.Circ;
   import com.greensock.easing.Cubic;
   import com.greensock.easing.Expo;
   
   public class KillAlertMessage extends UIComponent
   {
       
      
      public var ANIM_TIME_0:int = 15;
      
      public var ANIM_TIME_1:int = 8;
      
      public var ANIM_DELAY:int = 90;
      
      public var killerAvatar:tripwire.controls.TripUILoader;
      
      public var victimAvatar:tripwire.controls.TripUILoader;
      
      public var killerNameText:TextField;
      
      public var victimNameText:TextField;
      
      public var skullIcon:MovieClip;
      
      public var introTimeline:TimelineMax;
      
      public var fadeTimeline:TimelineMax;
      
      public var bHumanDeath:Boolean = false;
      
      public var iconOffset:int = 8;
      
      public var textOffset:int = 2;
      
      public var killerColor:uint = 12453376;
      
      public var victimColor:uint = 12255231;
      
      public var killerIconColor:Color;
      
      public var victimIconColor:Color;
      
      public const MAX_NAME_LENGTH:int = 20;
      
      public function KillAlertMessage()
      {
         this.introTimeline = new TimelineMax({
            "paused":true,
            "useFrames":true
         });
         this.fadeTimeline = new TimelineMax({
            "paused":true,
            "useFrames":true
         });
         this.killerIconColor = new Color();
         this.victimIconColor = new Color();
         super();
         alpha = 0;
         this.killerAvatar.visible = false;
         this.victimAvatar.visible = false;
      }
      
      public function set data(param1:*) : void
      {
         if(param1)
         {
            this.killerNameText.text = !!param1.killerName?param1.killerName:"";
            this.bHumanDeath = !!param1.humanDeath?Boolean(param1.humanDeath):false;
            this.victimAvatar.source = !!param1.killedIcon?param1.killedIcon:"";
            this.victimNameText.text = !!param1.killedName?param1.killedName:"";
            this.killerAvatar.source = !!param1.killerIcon?param1.killerIcon:"";
            this.killerColor = !!param1.killerTextColor?uint(param1.killerTextColor):uint(14538703);
            this.victimColor = !!param1.killedTextColor?uint(param1.killedTextColor):uint(14538703);
            this.truncateName(this.killerNameText);
            this.truncateName(this.victimNameText);
            this.moveItems();
         }
      }
      
      public function truncateName(param1:TextField) : void
      {
         if(param1.text.length > this.MAX_NAME_LENGTH)
         {
            param1.text = param1.text.slice(0,this.MAX_NAME_LENGTH);
            param1.appendText("...");
         }
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      public function moveItems() : void
      {
         var _loc1_:TextLineMetrics = null;
         _loc1_ = this.killerNameText.getLineMetrics(0);
         var _loc2_:TextLineMetrics = this.victimNameText.getLineMetrics(0);
         this.victimNameText.x = -_loc2_.width;
         if(!this.bHumanDeath && this.killerNameText.text == "")
         {
            this.skullIcon.x = this.victimNameText.x - this.skullIcon.width;
            this.killerNameText.x = this.skullIcon.x - (_loc1_.width + this.iconOffset);
         }
         else
         {
            this.killerAvatar.visible = true;
            this.victimAvatar.visible = true;
            this.victimAvatar.x = this.victimNameText.x - (this.victimAvatar.width + this.textOffset);
            this.skullIcon.x = this.victimAvatar.x - (this.skullIcon.width + this.iconOffset);
            this.killerNameText.x = this.skullIcon.x - (_loc1_.width + this.iconOffset);
            this.killerAvatar.x = this.killerNameText.x - (this.killerAvatar.width + this.textOffset);
            this.killerNameText.textColor = this.killerColor;
            this.victimNameText.textColor = this.victimColor;
            this.killerIconColor.setTint(this.killerColor,1);
            this.killerAvatar.transform.colorTransform = this.killerIconColor;
            this.victimIconColor.setTint(this.victimColor,1);
            this.victimAvatar.transform.colorTransform = this.victimIconColor;
         }
         TweenMax.delayedCall(1,this.openAnimation,[],true);
      }
      
      public function openAnimation() : void
      {
         var _loc1_:uint = 0;
         this.fadeTimeline.clear();
         this.fadeTimeline.to(this,8,{
            "alpha":0,
            "onComplete":this.onTweenComplete
         });
         this.introTimeline.clear();
         this.introTimeline.to(this,8,{
            "alpha":1,
            "ease":Circ.easeIn
         });
         if(this.bHumanDeath)
         {
            _loc1_ = this.victimNameText.textColor;
            this.introTimeline.fromTo(this,12,{"z":128},{
               "z":-32,
               "immediateRender":false,
               "ease":Cubic.easeOut
            },"-=8");
            this.introTimeline.append(TweenMax.allTo([this.victimNameText,this.victimAvatar],12,{
               "glowFilter":{
                  "color":_loc1_,
                  "blurX":8,
                  "blurY":8,
                  "strength":2,
                  "alpha":1
               },
               "ease":Cubic.easeOut
            }),"-=12");
            this.introTimeline.to(this,4,{
               "z":0,
               "ease":Cubic.easeIn
            });
            this.introTimeline.append(TweenMax.allTo([this.victimNameText,this.victimAvatar],4,{
               "glowFilter":{
                  "color":_loc1_,
                  "blurX":0,
                  "blurY":0,
                  "remove":true
               },
               "ease":Cubic.easeOut
            }),"-=4");
         }
         else
         {
            this.introTimeline.fromTo(this,16,{"z":128},{
               "z":0,
               "immediateRender":false,
               "ease":Expo.easeOut
            },"-=8");
         }
         this.introTimeline.append(TweenMax.delayedCall(this.ANIM_DELAY,this.fadeTimeline.restart,[],true));
         this.introTimeline.restart();
      }
      
      public function closeAnimation() : void
      {
         this.introTimeline.stop();
         this.fadeTimeline.play();
      }
      
      public function onTweenComplete() : void
      {
         dispatchEvent(new Event("onTweenComplete"));
      }
   }
}
