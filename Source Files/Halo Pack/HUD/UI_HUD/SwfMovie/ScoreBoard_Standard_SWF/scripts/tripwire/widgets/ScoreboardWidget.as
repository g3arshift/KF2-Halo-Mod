package tripwire.widgets
{
   import tripwire.containers.TripContainer;
   import flash.display.MovieClip;
   import tripwire.controls.scoreboard.ScoreboardScrollingList;
   import tripwire.containers.ScoreBoardMapInfoContainer;
   import flash.text.TextField;
   import tripwire.controls.scoreboard.ScoreboardLineRenderer;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   
   public class ScoreboardWidget extends TripContainer
   {
       
      
      public var serverInfoScan:MovieClip;
      
      public var serverInfoBG:MovieClip;
      
      public var PlayerScrollingList:ScoreboardScrollingList;
      
      public var ScoreboardMapInfo:ScoreBoardMapInfoContainer;
      
      public var playerText:TextField;
      
      public var doshText:TextField;
      
      public var killsText:TextField;
      
      public var assistsText:TextField;
      
      public var pingText:TextField;
      
      public var serverNameText:TextField;
      
      public var serverIPText:TextField;
      
      public var SCORE_ANIM_TIME:Number;
      
      public var SCORE_START_Z:Number;
      
      public var SCORE_OFFSET_Z:Number;
      
      public function ScoreboardWidget()
      {
         super();
         _enableInitCallback = true;
         visible = false;
         this.SCORE_ANIM_TIME = 4;
         this.SCORE_START_Z = 288;
         this.SCORE_OFFSET_Z = 112;
      }
      
      public function set avatarImage(param1:Object) : void
      {
         if(param1)
         {
            if(this.PlayerScrollingList.getRendererAt(param1.index) as ScoreboardLineRenderer != null)
            {
               (this.PlayerScrollingList.getRendererAt(param1.index) as ScoreboardLineRenderer).avatarLoader.source = param1.avatarPath;
            }
         }
      }
      
      public function set showScore(param1:Boolean) : void
      {
         if(param1)
         {
            openContainer();
         }
         else
         {
            closeContainer();
         }
      }
      
      override protected function openAnimation(param1:Boolean = true) : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,this.SCORE_ANIM_TIME,{
            "z":ANIM_START_Z + ANIM_OFFSET_Z,
            "alpha":0
         },{
            "z":ANIM_START_Z,
            "alpha":_defaultAlpha,
            "ease":Cubic.easeOut,
            "useFrames":true,
            "onComplete":onOpened
         });
      }
      
      override protected function closeAnimation() : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,this.SCORE_ANIM_TIME,{
            "z":ANIM_START_Z,
            "alpha":_defaultAlpha
         },{
            "z":ANIM_START_Z + ANIM_OFFSET_Z,
            "alpha":0,
            "ease":Cubic.easeIn,
            "useFrames":true,
            "onComplete":onClosed
         });
      }
      
      public function set localizeText(param1:Object) : void
      {
         if(this.playerText)
         {
            this.playerText.text = !!param1.playerText?param1.playerText:"";
         }
         if(this.doshText)
         {
            this.doshText.text = !!param1.doshText?param1.doshText:"";
         }
         if(this.killsText)
         {
            this.killsText.text = !!param1.killsText?param1.killsText:"";
         }
         if(this.assistsText)
         {
            this.assistsText.text = !!param1.assistsText?param1.assistsText:"";
         }
         if(this.pingText)
         {
            this.pingText.text = !!param1.pingText?param1.pingText:"";
         }
      }
      
      public function set playerData(param1:Array) : void
      {
         this.PlayerScrollingList.updatePlayerData(param1);
      }
      
      public function set serverInfo(param1:Object) : void
      {
         this.serverNameText.text = !!param1.serverName?param1.serverName:"";
         this.serverIPText.text = !!param1.serverIP?param1.serverIP:"";
         this.serverInfoScan.visible = this.serverInfoBG.visible = this.serverNameText.text == "" && this.serverIPText.text == "" || bManagerConsoleBuild?false:true;
      }
   }
}
