package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import tripwire.controls.voiceComms.VoiceCommsOptionRenderer;
   import flash.events.Event;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class VoiceCommsWidget extends UIComponent
   {
       
      
      public var ballA:MovieClip;
      
      public var ballB:MovieClip;
      
      public var selectedItem:VoiceCommsOptionRenderer;
      
      public var bUsingGamePad:Boolean = false;
      
      public var ballARadius:Number;
      
      public var ballBRadius:Number;
      
      public var initialZ:Number;
      
      private const NUM_OPTIONS:int = 8;
      
      private const BOUNDARY_BUFFER:Number = 32;
      
      public function VoiceCommsWidget()
      {
         super();
         enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.initValues();
         visible = false;
         alpha = 0;
      }
      
      public function initValues() : *
      {
         this.initialZ = this.z;
         this.ballARadius = this.ballA.width / 2;
         this.ballBRadius = this.ballB.width / 2 - 15.15;
      }
      
      public function set textOptions(param1:Object) : void
      {
         var _loc2_:Number = 0;
         while(_loc2_ < this.NUM_OPTIONS)
         {
            if(_loc2_ < param1.length)
            {
               this["Item" + _loc2_].data = param1[_loc2_];
            }
            else
            {
               this["Item" + _loc2_].data = null;
            }
            this["Item" + _loc2_].itemIndex = _loc2_;
            _loc2_++;
         }
      }
      
      public function enableComm() : void
      {
         dispatchEvent(new Event("PopoutItems",true));
         TweenMax.fromTo(this,4,{
            "autoAlpha":0,
            "z":this.initialZ + 256
         },{
            "autoAlpha":0.88,
            "z":this.initialZ,
            "useFrames":true,
            "overwrite":1,
            "ease":Cubic.easeOut
         });
         if(!visible)
         {
            this.ballA.x = this.ballB.x;
            this.ballA.y = this.ballB.y;
         }
      }
      
      public function setNormalizedMousePosition(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(param3)
         {
            this.ballA.x = this.ballA.x + param1;
            this.ballA.y = this.ballA.y + param2;
         }
         else
         {
            this.ballA.x = param1 * this.ballB.width / 2 + this.ballB.x;
            this.ballA.y = param2 * this.ballB.height / 2 + this.ballB.y;
         }
         this.checkBallRadius();
         this.activateText();
      }
      
      public function disableComm() : void
      {
         if(visible)
         {
            if(this.selectedItem)
            {
               this.selectedItem.deactivateItem();
            }
            dispatchEvent(new Event("PopinItems",true));
            TweenMax.fromTo(this,4,{
               "alpha":0.88,
               "z":this.initialZ
            },{
               "alpha":0,
               "z":this.initialZ + 256,
               "visible":false,
               "delay":2,
               "useFrames":true,
               "ease":Cubic.easeIn
            });
            this.callSelectedItem();
         }
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         if(visible)
         {
            this.callSelectedItem();
         }
      }
      
      public function callSelectedItem() : *
      {
         if(this.selectedItem)
         {
            this.selectedItem.selectActiveItem();
            ExternalInterface.call("Callback_VoiceCommsSay",this.selectedItem.itemIndex);
         }
      }
      
      public function activateText() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = 0;
         while(_loc2_ < this.NUM_OPTIONS)
         {
            _loc1_ = this["ItemBound" + _loc2_];
            if(this.ballA.x >= _loc1_.x && this.ballA.x <= _loc1_.x + _loc1_.width && (this.ballA.y <= _loc1_.y + _loc1_.height && this.ballA.y >= _loc1_.y))
            {
               if(this.selectedItem != null)
               {
                  this.selectedItem.deactivateItem();
               }
               this.selectedItem = this["Item" + _loc2_];
               this.selectedItem.activateItem();
               return;
            }
            _loc2_++;
         }
         if(this.selectedItem != null)
         {
            this.selectedItem.deactivateItem();
            this.selectedItem = null;
         }
      }
      
      public function checkBallRadius() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:Number = this.ballA.x - this.ballB.x;
         var _loc2_:Number = this.ballA.y - this.ballB.y;
         var _loc3_:Number = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         if(_loc3_ > this.ballBRadius - this.ballARadius)
         {
            _loc4_ = _loc3_ - (this.ballBRadius - this.ballARadius);
            this.ballA.x = this.ballA.x - _loc1_ / _loc3_ * _loc4_;
            this.ballA.y = this.ballA.y - _loc2_ / _loc3_ * _loc4_;
         }
      }
      
      public function popAssets(param1:String) : void
      {
         dispatchEvent(new Event(param1));
      }
   }
}
