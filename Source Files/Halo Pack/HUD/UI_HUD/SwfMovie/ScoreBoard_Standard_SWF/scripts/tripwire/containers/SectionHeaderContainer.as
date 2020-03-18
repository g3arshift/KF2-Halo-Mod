package tripwire.containers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.events.Event;
   import tripwire.managers.MenuManager;
   
   public class SectionHeaderContainer extends TripContainer
   {
       
      
      public var headerIcon:MovieClip;
      
      public var leftTriggerIcon:MovieClip;
      
      public var textField:TextField;
      
      private var _controllerIconVisible:Boolean = true;
      
      public function SectionHeaderContainer()
      {
         super();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.headerIcon.visible = true;
         if(this.leftTriggerIcon)
         {
            this.leftTriggerIcon.visible = false;
         }
         stage.addEventListener(MenuManager.INPUT_CHANGED,this.onInputChange,false,0,true);
      }
      
      override protected function onInputChange(param1:Event) : *
      {
         super.onInputChange(param1);
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
      }
      
      public function get text() : String
      {
         return this.textField.text;
      }
      
      public function get controllerIconVisible() : Boolean
      {
         return this._controllerIconVisible;
      }
      
      public function set controllerIconVisible(param1:Boolean) : *
      {
         if(this._controllerIconVisible == param1)
         {
            return;
         }
         this._controllerIconVisible = param1;
      }
   }
}
