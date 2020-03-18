package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import com.greensock.TweenMax;
   import com.greensock.TimelineMax;
   
   public class BossNameplateWidget extends UIComponent
   {
       
      
      public var bossNameTextField:TextField;
      
      public var subTextField:TextField;
      
      public var bossNameContainer:MovieClip;
      
      public var subTextContainer:MovieClip;
      
      public var bossTimeline;
      
      public function BossNameplateWidget()
      {
         this.bossTimeline = new TimelineMax({"useFrames":true});
         super();
         enableInitCallback = true;
         visible = false;
      }
      
      public function setText(param1:String, param2:String) : void
      {
         this.setTimeline();
         this.bossNameTextField = this.bossNameContainer.bossNameTextField;
         this.subTextField = this.subTextContainer.subTextField;
         this.bossNameTextField.text = param1;
         this.subTextField.text = param2;
         this.startAnim();
      }
      
      public function setTimeline() : void
      {
         this.bossTimeline.fromTo(this,60,{
            "rotationY":0,
            "z":0
         },{});
         this.bossTimeline.to(this,1,{"visible":true});
         this.bossTimeline.to(this,7,{
            "rotationY":8,
            "z":-72
         });
         this.bossTimeline.to(this,7,{
            "rotationY":12,
            "z":-80
         });
         this.bossTimeline.to(this,105,{
            "rotationY":24,
            "z":-160
         });
      }
      
      public function startAnim() : void
      {
         TweenMax.to(this,60,{
            "useFrames":true,
            "onComplete":gotoAndPlay,
            "onCompleteParams":["Play"]
         });
         this.bossTimeline.play();
      }
   }
}
