package tripwire.widgets
{
   import tripwire.containers.TripContainer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import tripwire.Tools.TextfieldUtil;
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import flash.external.ExternalInterface;
   import scaleform.clik.events.InputEvent;
   
   public class KickVoteWidget extends TripContainer
   {
       
      
      public var voteKickText:TextField;
      
      public var playerNameText:TextField;
      
      public var yesKeyText:TextField;
      
      public var noKeyText:TextField;
      
      public var yesText:TextField;
      
      public var noText:TextField;
      
      public var yesIndicator:MovieClip;
      
      public var noIndicator:MovieClip;
      
      public var bIcon:MovieClip;
      
      public var aIcon:MovieClip;
      
      public var scanLines_Main:MovieClip;
      
      public var background_Main:MovieClip;
      
      public const keyDownString:String = "keyDown";
      
      public const keyUpString:String = "keyUp";
      
      public const voteHoldTime:Number = 1000;
      
      private var _bChoicesVisible:Boolean = false;
      
      public var voteTimeText:TextField;
      
      public var yesVotesText:TextField;
      
      public var yesCountText:TextField;
      
      public var noVotesText:TextField;
      
      public var noCountText:TextField;
      
      private var _voteTimer:Timer;
      
      private var _currentTime:int;
      
      public function KickVoteWidget()
      {
         super();
         visible = false;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this._voteTimer = new Timer(1000);
         this._voteTimer.addEventListener(TimerEvent.TIMER,this.countdownTimer,false,0,true);
         this.onYesReleased();
         this.onNoReleased();
      }
      
      public function set bUsingGamepad(param1:Boolean) : void
      {
         if(this._bChoicesVisible)
         {
            this.aIcon.visible = param1;
            this.bIcon.visible = param1;
            this.yesKeyText.visible = !param1;
            this.noKeyText.visible = !param1;
         }
      }
      
      public function set localizedText(param1:Object) : void
      {
         if(param1)
         {
            this.voteKickText.text = !!param1.voteKick?param1.voteKick:"voteKick";
            this.yesKeyText.text = !!param1.yesKey?param1.yesKey:"";
            this.noKeyText.text = !!param1.noKey?param1.noKey:"";
            this.yesText.text = !!param1.yes?param1.yes:"yes?";
            this.noText.text = !!param1.no?param1.no:"no?";
            this.yesVotesText.text = !!param1.yes?param1.yes:"yes!";
            this.noVotesText.text = !!param1.no?param1.no:"no!";
         }
      }
      
      public function set kickVoteData(param1:Object) : void
      {
         if(param1)
         {
            this.playerNameText.text = !!param1.playerName?param1.playerName:"name not passed!";
            trace("THIS IS THE VALUE PASSED TO KICK VOTE:",param1.playerName);
            visible = true;
            this._currentTime = !!param1.voteDuation?int(param1.voteDuraction - 1):0;
            this.voteTimeText.text = TextfieldUtil.instance.getFormattedTimeFromSeconds(this._currentTime);
            this._voteTimer.repeatCount = param1.voteDuation;
            this._voteTimer.reset();
            this._voteTimer.start();
            this.choicesVisibility = !!param1.bShowChoices?Boolean(param1.bShowChoices):false;
         }
         else
         {
            this.ClearVoteKick();
         }
      }
      
      public function updateKickVoteCount(param1:int, param2:int) : void
      {
         this.yesCountText.text = param1.toString();
         this.noCountText.text = param2.toString();
      }
      
      public function onYesPressed() : void
      {
         if(!this.yesIndicator.visible && this._bChoicesVisible)
         {
            this.yesIndicator.visible = true;
            TweenMax.to(this.yesIndicator,1,{
               "usesFrame":true,
               "frame":35,
               "onComplete":this.onYesVoteComplete
            });
            if(this.noIndicator.visible)
            {
               this.onNoReleased();
            }
         }
      }
      
      public function onNoPressed() : void
      {
         if(!this.noIndicator.visible && this._bChoicesVisible)
         {
            this.noIndicator.visible = true;
            TweenMax.to(this.noIndicator,1,{
               "usesFrame":true,
               "frame":35,
               "onComplete":this.onNoVoteComplete
            });
            if(this.yesIndicator.visible)
            {
               this.onYesReleased();
            }
         }
      }
      
      public function onYesReleased() : void
      {
         this.yesIndicator.visible = false;
         TweenMax.killTweensOf(this.yesIndicator);
         this.yesIndicator.gotoAndStop(0);
      }
      
      public function onNoReleased() : void
      {
         this.noIndicator.visible = false;
         TweenMax.killTweensOf(this.noIndicator);
         this.noIndicator.gotoAndStop(0);
      }
      
      public function onYesVoteComplete(param1:TweenEvent = null) : *
      {
         this.castVote(true);
      }
      
      public function onNoVoteComplete(param1:TweenEvent = null) : *
      {
         this.castVote(false);
      }
      
      public function castVote(param1:Boolean) : void
      {
         ExternalInterface.call("Callback_VoteKick",param1);
         this.choicesVisibility = false;
      }
      
      public function set choicesVisibility(param1:Boolean) : void
      {
         this._bChoicesVisible = param1;
         this.playerNameText.visible = param1;
         this.yesText.visible = param1;
         this.noText.visible = param1;
         this.yesKeyText.visible = param1 && !bManagerUsingGamepad;
         this.noKeyText.visible = param1 && !bManagerUsingGamepad;
         this.aIcon.visible = param1 && bManagerUsingGamepad;
         this.bIcon.visible = param1 && bManagerUsingGamepad;
         this.scanLines_Main.visible = param1;
         this.background_Main.visible = param1;
         this.voteKickText.visible = param1;
      }
      
      private function countdownTimer(param1:TimerEvent) : void
      {
         this._currentTime = Math.max(this._currentTime - 1,0);
         this.voteTimeText.text = TextfieldUtil.instance.getFormattedTimeFromSeconds(this._currentTime);
      }
      
      public function ClearVoteKick() : void
      {
         this.playerNameText.text = "";
         visible = false;
         this.noIndicator.visible = false;
         this.noIndicator.stop();
         this.yesIndicator.visible = false;
         this.yesIndicator.stop();
         if(stage)
         {
            stage.removeEventListener(InputEvent.INPUT,handleInput);
         }
      }
   }
}
