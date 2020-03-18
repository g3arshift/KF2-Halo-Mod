package tripwire.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   
   public class BaseButton extends UIComponent
   {
      
      public static const BUTTON_SELECTED:String = "buttonSelected";
       
      
      protected var _bTraversable:Boolean = false;
      
      protected var _bStaySelected:Boolean = true;
      
      protected var _bSelected:Boolean = false;
      
      protected var _bHighlighted:Boolean = false;
      
      private var _traversableIndex:int;
      
      private var _enabled:Boolean = true;
      
      public function BaseButton()
      {
         super();
         this.addEventListeners();
      }
      
      public function get bStaySelected() : Boolean
      {
         return this._bStaySelected;
      }
      
      public function set bStaySelected(param1:Boolean) : void
      {
         this._bStaySelected = param1;
      }
      
      public function get traversableIndex() : int
      {
         return this._traversableIndex;
      }
      
      public function set traversableIndex(param1:int) : void
      {
         this._traversableIndex = param1;
      }
      
      public function get bTraversable() : Boolean
      {
         return this._bTraversable;
      }
      
      public function set bTraversable(param1:Boolean) : void
      {
         this._bTraversable = param1;
      }
      
      public function get bSelected() : Boolean
      {
         return this._bSelected;
      }
      
      public function set bSelected(param1:Boolean) : void
      {
         this._bSelected = param1;
      }
      
      override public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == this.enabled)
         {
            return;
         }
         if(param1)
         {
            gotoAndPlay("unselected");
         }
         else
         {
            gotoAndPlay("disabled");
            this.bSelected = false;
         }
         mouseEnabled = param1;
         mouseChildren = param1;
         tabEnabled = !param1?false:Boolean(_focusable);
         this._enabled = param1;
      }
      
      public function addEventListeners() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      public function removeEventListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      protected function onOver(param1:MouseEvent) : void
      {
         this.highlighted();
      }
      
      protected function onOut(param1:MouseEvent) : void
      {
         this.unhighlighted();
      }
      
      protected function onDown(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(BUTTON_SELECTED));
      }
      
      public function onUp(param1:MouseEvent) : void
      {
         if(this._bSelected && !this.bTraversable)
         {
            gotoAndPlay("up");
            if(this.bStaySelected)
            {
               this._bSelected = false;
            }
         }
      }
      
      public function highlighted() : void
      {
         if(!this._bSelected)
         {
            gotoAndPlay("over");
            this._bHighlighted = true;
         }
      }
      
      public function unhighlighted() : void
      {
         if(!this._bSelected)
         {
            gotoAndPlay("out");
            this._bHighlighted = false;
         }
      }
      
      public function selected() : void
      {
         if(!this._bSelected)
         {
            gotoAndPlay("selected");
            if(this.bStaySelected)
            {
               this._bSelected = true;
            }
         }
      }
      
      public function unselected() : void
      {
         if(this._bSelected)
         {
            gotoAndPlay("unselected");
            this._bSelected = false;
         }
      }
   }
}
