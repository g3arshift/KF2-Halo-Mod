package tripwire.controls
{
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.gfx.TextFieldEx;
   
   public class CategoryButton extends TripButton
   {
       
      
      public var titleTextField:TextField;
      
      public var infoTextField:TextField;
      
      private var _infoString:String;
      
      public var highlightColor:uint = 16503487;
      
      public var defaultColor:uint = 12234399;
      
      public var disabledColor:uint = 8743272;
      
      public var hitbox2:MovieClip;
      
      public const hitboxZ:int = 0;
      
      public function CategoryButton()
      {
         super();
         doAnimations = true;
         TextFieldEx.setVerticalAlign(this.infoTextField,TextFieldEx.VALIGN_CENTER);
         overSoundEffect = "TITLE_BUTTON_ROLLOVER";
      }
      
      public function get infoString() : String
      {
         return this._infoString;
      }
      
      public function set infoString(param1:String) : void
      {
         if(this._infoString == param1)
         {
            return;
         }
         this._infoString = param1;
         invalidateData();
      }
      
      public function setText(param1:Object) : *
      {
         label = param1.titleString;
         this.infoString = param1.infoString;
         invalidateData();
      }
      
      override protected function updateText() : void
      {
         if(_label != null && this.titleTextField != null)
         {
            this.titleTextField.text = _label;
         }
         if(this._infoString != null && this.infoTextField != null)
         {
            this.infoTextField.text = this._infoString;
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(param1)
         {
            this.highlightButton();
         }
         else
         {
            this.unhighlightButton();
         }
      }
      
      override protected function highlightButton() : *
      {
         super.highlightButton();
         this.infoTextField.textColor = this.highlightColor;
         TextFieldEx.setVerticalAlign(this.infoTextField,TextFieldEx.VALIGN_CENTER);
         this.hitbox2.z = this.hitboxZ;
      }
      
      override protected function unhighlightButton() : *
      {
         super.unhighlightButton();
         this.infoTextField.textColor = this.defaultColor;
         TextFieldEx.setVerticalAlign(this.infoTextField,TextFieldEx.VALIGN_CENTER);
         this.hitbox2.z = 0;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(!param1)
         {
            TextFieldEx.setVerticalAlign(this.infoTextField,TextFieldEx.VALIGN_CENTER);
            this.infoTextField.textColor = this.disabledColor;
         }
      }
   }
}
