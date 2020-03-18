package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.controls.UILoader;
   
   public class SpectatorInfoWidget extends UIComponent
   {
       
      
      public var playerNameText:TextField;
      
      public var playerPerkText:TextField;
      
      public var prevPlayerText:TextField;
      
      public var nextPlayerText:TextField;
      
      public var changeCameraText:TextField;
      
      public var iconLoader:UILoader;
      
      private var _bUsingGamePad:Boolean;
      
      public function SpectatorInfoWidget()
      {
         super();
         enableInitCallback = true;
      }
      
      public function set bUsingGamePad(param1:Boolean) : void
      {
         if(param1 != this._bUsingGamePad)
         {
            this._bUsingGamePad = param1;
            if(this._bUsingGamePad)
            {
               gotoAndStop("gamePad");
            }
            else
            {
               gotoAndStop("keyboard");
            }
         }
      }
      
      public function set localizedText(param1:Object) : void
      {
         this.prevPlayerText.text = !!param1.prevPlayer?param1.prevPlayer:"";
         this.nextPlayerText.text = !!param1.nextPlayer?param1.nextPlayer:"";
         this.changeCameraText.text = !!param1.changeCamera?param1.changeCamera:"";
      }
      
      public function set playerData(param1:Object) : void
      {
         this.playerNameText.text = !!param1.playerName?param1.playerName:"";
         this.playerPerkText.text = !!param1.playerPerk?param1.playerPerk:"";
         this.iconLoader.source = !!param1.iconPath?param1.iconPath:"";
         visible = true;
      }
   }
}
