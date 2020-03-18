package tripwire.controls.scoreboard
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import tripwire.controls.TripUILoader;
   
   public class ScoreboardLineRenderer extends ListItemRenderer
   {
       
      
      public var playerNameText:TextField;
      
      public var pingText:TextField;
      
      public var killsText:TextField;
      
      public var assistsText:TextField;
      
      public var perkInfoText:TextField;
      
      public var doshText:TextField;
      
      public var playerHealthText:TextField;
      
      public var healthGaugeMC:MovieClip;
      
      public var avatarMask:MovieClip;
      
      public var avatarContainer:MovieClip;
      
      public var doshIcon:MovieClip;
      
      private const PS4_CHAR_LIMIT:int = 16;
      
      public var doshiconStartX:Number;
      
      public var avatarLoader:TripUILoader;
      
      public var perkIconLoader:TripUILoader;
      
      public var playerID:int;
      
      public var currentPlayerName:String;
      
      public function ScoreboardLineRenderer()
      {
         super();
         preventAutosizing = true;
         if(this.doshIcon != null)
         {
            this.doshiconStartX = this.doshIcon.x;
         }
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         if(param1)
         {
            visible = true;
            this.playerID = !!param1.playerID?int(param1.playerID):-1;
            this.playerName = !!param1.playername?param1.playername:"---";
            this.pingText.text = !!param1.ping?param1.ping:"-";
            this.killsText.text = !!param1.kills?param1.kills:"0";
            this.assistsText.text = !!param1.assists?param1.assists:"0";
            this.doshAmount = !!param1.dosh?param1.dosh:"0";
            this.perkInfoText.text = (!!param1.perkLevel?param1.perkLevel:"0") + " " + (!!param1.perkName?param1.perkName:"");
            this.iconSource = param1.iconPath;
            if(param1.avatar)
            {
               this.avatarIcon = param1.avatar;
            }
            this.setHealthState(!!param1.health?int(param1.health):0,!!param1.healthPercent?int(param1.healthPercent):0);
         }
         else
         {
            visible = false;
         }
      }
      
      public function set avatarIcon(param1:String) : void
      {
         if(param1 && param1 != "")
         {
            this.avatarLoader.source = param1;
            this.avatarLoader.visible = true;
         }
         else
         {
            this.avatarLoader.visible = false;
         }
      }
      
      public function set doshAmount(param1:String) : void
      {
         if(this.doshText.text != param1)
         {
            this.doshText.text = param1;
            this.doshIcon.x = this.doshiconStartX;
            this.doshIcon.x = this.doshIcon.x + (this.doshText.textWidth <= this.doshText.width?(this.doshText.width - this.doshText.textWidth) / 2 - 2:0);
         }
      }
      
      public function set playerName(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.currentPlayerName != param1)
         {
            this.currentPlayerName = this.playerNameText.text = param1;
            if(this.playerNameText.textWidth > this.playerNameText.width && param1.length > this.PS4_CHAR_LIMIT)
            {
               _loc2_ = this.playerNameText.getCharIndexAtPoint(this.playerNameText.width - 16,this.playerNameText.height / 2);
               _loc3_ = this.playerNameText.getCharIndexAtPoint(this.playerNameText.width - 2,this.playerNameText.height / 2);
               _loc3_ = _loc3_ - (_loc3_ - _loc2_);
               this.playerNameText.text = param1.slice(0,_loc3_) + "...";
            }
         }
      }
      
      public function setHealthState(param1:int, param2:int) : void
      {
         var _loc3_:int = param1;
         if(this.playerHealthText != null)
         {
            this.playerHealthText.text = param1.toString();
         }
         if(param2 > 100)
         {
            _loc3_ = 100;
         }
         else if(param2 < 0)
         {
            _loc3_ = 0;
         }
         if(param2 > 0)
         {
            if(currentFrameLabel != "Alive")
            {
               gotoAndStop("Alive");
            }
         }
         else if(currentFrameLabel != "Dead")
         {
            gotoAndStop("Dead");
         }
         if(this.healthGaugeMC)
         {
            this.healthGaugeMC.gotoAndStop(param2 + 1);
         }
      }
      
      public function set iconSource(param1:String) : void
      {
         if(param1 && param1 != "")
         {
            this.perkIconLoader.source = param1;
         }
      }
   }
}
