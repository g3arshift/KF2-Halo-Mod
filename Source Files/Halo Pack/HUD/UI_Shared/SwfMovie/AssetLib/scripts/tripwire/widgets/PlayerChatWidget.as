package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import tripwire.controls.PlayerChatScrollingList;
   import scaleform.clik.controls.TextInput;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.FocusEvent;
   import flash.external.ExternalInterface;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import flash.events.TimerEvent;
   import scaleform.clik.data.DataProvider;
   
   public class PlayerChatWidget extends UIComponent
   {
       
      
      public var ChatHistory:PlayerChatScrollingList;
      
      public var ChatInputField:TextInput;
      
      private var _bShowInputField:Boolean;
      
      private var _sizingField:TextField;
      
      private var closeTimer:Timer;
      
      private const closeTime:int = 250;
      
      private var bCloseTimerExpired:Boolean = true;
      
      private var _bIsPartyChat:Boolean = false;
      
      public var ChatScanlines:MovieClip;
      
      public var inputFormat:TextFormat;
      
      public function PlayerChatWidget()
      {
         this._sizingField = new TextField();
         super();
         _enableInitCallback = true;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPress,false,0,true);
         this.ChatHistory.inputTextFieldHeight = this.ChatInputField.textField.height;
         this.setShowInputField(this._bIsPartyChat);
         this.initChatSizingField();
         tabChildren = false;
         mouseEnabled = mouseChildren = this._bIsPartyChat;
         this.ChatInputField.mouseEnabled = this.ChatInputField.mouseChildren = false;
         if(this.ChatScanlines != null)
         {
            this.ChatScanlines.mouseEnabled = false;
            this.ChatScanlines.mouseChildren = false;
         }
         this.ChatInputField.tabIndex = 1;
         this.ChatInputField.addEventListener(FocusEvent.FOCUS_IN,this.chatFocusIn,false,0,true);
         this.ChatInputField.addEventListener(FocusEvent.FOCUS_OUT,this.chatFocusOut,false,0,true);
      }
      
      public function chatFocusIn(param1:FocusEvent) : void
      {
         this.ChatHistory.bEnableMouseWheelScroll = true;
         ExternalInterface.call("Callback_ChatFocusIn");
      }
      
      public function chatFocusOut(param1:FocusEvent) : void
      {
         this.ChatHistory.bEnableMouseWheelScroll = false;
         ExternalInterface.call("Callback_ChatFocusOut");
      }
      
      public function InitializeAsPartyChat() : void
      {
         this._bIsPartyChat = true;
         this.setShowInputField(this._bIsPartyChat);
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         mouseEnabled = mouseChildren = this._bIsPartyChat;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(stage.focus != this.ChatInputField && this._bIsPartyChat)
         {
            stage.focus = this.ChatInputField;
         }
         else if(this.bCloseTimerExpired)
         {
            this.setShowInputField(false);
            ExternalInterface.call("Callback_ChatBoxClosed");
         }
         else
         {
            stage.focus = this.ChatInputField;
         }
      }
      
      private function initChatSizingField() : void
      {
         this._sizingField.defaultTextFormat = this.ChatInputField.textField.getTextFormat();
         this._sizingField.multiline = true;
         this._sizingField.wordWrap = true;
      }
      
      public function onKeyPress(param1:KeyboardEvent) : void
      {
         if(stage.focus == this.ChatInputField.textField)
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               if(this._bShowInputField || this._bIsPartyChat)
               {
                  ExternalInterface.call("Callback_BroadcastChatMessage",this.ChatInputField.text);
                  this.ClearAndCloseChat();
               }
            }
            else if(param1.keyCode == Keyboard.ESCAPE)
            {
               if(this._bShowInputField || this._bIsPartyChat)
               {
                  this.ClearAndCloseChat();
               }
            }
         }
      }
      
      public function ClearAndCloseChat() : void
      {
         if(this.ChatInputField.text.length > 0)
         {
            this.ChatInputField.text = "";
         }
         this.setShowInputField(false);
      }
      
      public function onOpenInput() : void
      {
         this.setShowInputField(true);
      }
      
      public function addChatMessage(param1:String, param2:String) : void
      {
         this._sizingField.width = this.ChatHistory.width;
         this._sizingField.text = param1;
         var _loc3_:int = 0;
         while(_loc3_ < this._sizingField.numLines)
         {
            this.ChatHistory.addChatMessage(this._sizingField.getLineText(_loc3_),param2);
            _loc3_++;
         }
      }
      
      private function setShowInputField(param1:Boolean) : void
      {
         if(param1)
         {
            this.showChatElements(param1 || this._bIsPartyChat);
            this.bCloseTimerExpired = false;
            this.closeTimer = new Timer(this.closeTime,1);
            this.closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCloseTimer,false,0,true);
            this.closeTimer.start();
            stage.focus = this.ChatInputField.textField;
            if(!this._bIsPartyChat)
            {
               stage.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
            }
         }
         else if(this.bCloseTimerExpired && !this._bIsPartyChat)
         {
            this.showChatElements(false);
            stage.removeEventListener(MouseEvent.CLICK,this.onClick);
            stage.focus = null;
            ExternalInterface.call("Callback_ChatBoxClosed");
         }
      }
      
      private function showChatElements(param1:Boolean) : void
      {
         this._bShowInputField = param1;
         this.ChatHistory.setShowHistory(param1);
         this.ChatInputField.visible = param1;
         if(this.ChatScanlines != null)
         {
            this.ChatScanlines.visible = param1;
         }
      }
      
      private function onCloseTimer(param1:TimerEvent) : void
      {
         this.bCloseTimerExpired = true;
      }
      
      public function getDataObjects() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = new Array();
         if(this.ChatHistory != null && this.ChatHistory.ChatHistoryDP != null && this.ChatHistory.ChatHistoryDP.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.ChatHistory.ChatHistoryDP.length)
            {
               _loc1_.push(this.ChatHistory.ChatHistoryDP[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function set dataObjects(param1:Array) : void
      {
         this.ChatHistory.ChatHistoryDP = new DataProvider(param1);
         this.ChatHistory.dataProvider = this.ChatHistory.ChatHistoryDP;
         this.ChatHistory.invalidateData();
      }
   }
}
