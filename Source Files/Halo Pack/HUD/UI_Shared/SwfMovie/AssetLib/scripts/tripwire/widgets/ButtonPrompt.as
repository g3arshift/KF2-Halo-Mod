package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   
   public class ButtonPrompt extends UIComponent
   {
       
      
      public var promptIcon:IconStack;
      
      public var PromptTF:TextField;
      
      public var iconTextBuffer:Number = 4;
      
      private var _buttonLabel:String;
      
      private var _promptText:String;
      
      private var _promptData:Object;
      
      private var _frameCount:Number = 0;
      
      public function ButtonPrompt()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.PromptTF.autoSize = "left";
      }
      
      public function get promptData() : Object
      {
         return this._promptData;
      }
      
      public function set promptData(param1:Object) : void
      {
         if(param1 == null || param1 == this._promptData)
         {
            return;
         }
         this._promptData = param1;
         if(this._buttonLabel != this._promptData.buttonLabel)
         {
            this._buttonLabel = this._promptData.buttonLabel;
            if(this.promptIcon)
            {
               this.promptIcon.gotoAndStop(this._buttonLabel);
               this.promptIcon.visible = true;
            }
         }
         if(this._promptText != this._promptData.promptText)
         {
            this._promptText = this._promptData.promptText;
            this.PromptTF.text = this._promptText;
         }
         this.updateTextPosition();
      }
      
      public function get buttonDisplay() : String
      {
         return this._buttonLabel;
      }
      
      public function set buttonDisplay(param1:String) : *
      {
         this._buttonLabel = param1;
         if(this.promptIcon)
         {
            this.promptIcon.gotoAndStop(this._buttonLabel);
            this.promptIcon.visible = true;
            this.updateTextPosition();
         }
      }
      
      public function get promptText() : String
      {
         return this._promptText;
      }
      
      public function set promptText(param1:String) : *
      {
         this._promptText = param1;
         this.PromptTF.text = this._promptText;
         this.updateTextPosition();
      }
      
      override public function get width() : Number
      {
         return this.promptIcon.width + this.iconTextBuffer + this.PromptTF.textWidth;
      }
      
      private function updateTextPosition() : void
      {
         if(this.PromptTF && this.promptIcon)
         {
            this.PromptTF.x = this.promptIcon.x + this.promptIcon.width + this.iconTextBuffer;
         }
      }
   }
}
