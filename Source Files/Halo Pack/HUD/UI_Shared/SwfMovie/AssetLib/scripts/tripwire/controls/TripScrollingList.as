package tripwire.controls
{
   import scaleform.clik.controls.ScrollingList;
   import flash.display.MovieClip;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import tripwire.managers.MenuManager;
   import com.greensock.easing.Cubic;
   import flash.events.FocusEvent;
   import scaleform.clik.events.IndexEvent;
   import tripwire.containers.TripContainer;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.gfx.FocusManager;
   
   public class TripScrollingList extends ScrollingList
   {
       
      
      public var associatedButton:tripwire.controls.TripButton;
      
      public var background:MovieClip;
      
      public var redBar:MovieClip;
      
      public var bStayOpenOnSelection:Boolean = false;
      
      protected var _defaultAlpha:Number;
      
      protected var _dimmedAlpha:Number = 0.6;
      
      private var _type:String;
      
      private var _bOpen:Boolean;
      
      private var _fadeIn:TweenMax;
      
      private var _fadeOut:TweenMax;
      
      private var _startingIndex:int;
      
      public var Owner:Object;
      
      public var bDropDown:Boolean = false;
      
      public function TripScrollingList()
      {
         super();
         focused = 0;
         this._defaultAlpha = alpha;
      }
      
      override protected function drawScrollBar() : void
      {
         if(!_autoScrollBar)
         {
            return;
         }
         _scrollBar.x = _width - _scrollBar.width - margin;
         _scrollBar.y = margin + padding.top;
         _scrollBar.height = availableHeight - 8;
         _scrollBar.validateNow();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      override protected function draw() : void
      {
         margin = 10;
         super.draw();
      }
      
      public function get bManagerUsingGamepad() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bUsingGamepad;
         }
         return false;
      }
      
      public function get bOpen() : Boolean
      {
         return this._bOpen;
      }
      
      public function set bOpen(param1:Boolean) : void
      {
         this._bOpen = param1;
         if(param1)
         {
            this.open(this.bManagerUsingGamepad);
         }
         else
         {
            this.close();
         }
      }
      
      override protected function updateScrollBar() : void
      {
         if(scrollBar != null)
         {
            scrollBar.visible = dataProvider.length > _totalRenderers;
         }
         super.updateScrollBar();
      }
      
      protected function open(param1:Boolean = true) : void
      {
         if(this.associatedButton != null)
         {
            this.associatedButton.selected = true;
         }
         focusable = true;
         focused = 1;
         this._startingIndex = this.selectedIndex;
         if(!this.bManagerUsingGamepad)
         {
            this.selectedIndex = -1;
         }
         visible = true;
         mouseEnabled = true;
         TweenMax.killTweensOf(this);
         this._fadeIn = TweenMax.fromTo(this,4,{
            "z":48,
            "alpha":0
         },{
            "z":0,
            "alpha":(!!param1?this._defaultAlpha:this._dimmedAlpha),
            "ease":Cubic.easeOut,
            "useFrames":true,
            "onComplete":this.onOpen,
            "onCompleteParams":[this.bManagerUsingGamepad]
         });
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut,false,0,true);
      }
      
      public function indexChanged(param1:IndexEvent) : void
      {
      }
      
      protected function close(param1:FocusEvent = null) : void
      {
         if(this.associatedButton != null)
         {
            this.associatedButton.selected = false;
         }
         mouseEnabled = false;
         TweenMax.killTweensOf(this);
         this._fadeOut = TweenMax.fromTo(this,4,{"alpha":1},{
            "alpha":0,
            "ease":Cubic.easeOut,
            "useFrames":true,
            "onComplete":this.onClose
         });
         removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
      }
      
      function onFocusOut(param1:FocusEvent) : *
      {
         this.closeList(TripContainer.CANCELLED_INDEX);
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void
      {
         super.handleItemClick(param1);
         this.closeList((param1.currentTarget as IListItemRenderer).index);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(this.bDropDown)
         {
            param1.handled = false;
            return;
         }
         if(_loc2_.value == InputValue.KEY_DOWN)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.GAMEPAD_A:
                  this.closeList(_selectedIndex);
                  param1.handled = true;
                  break;
               case NavigationCode.UP:
                  break;
               case NavigationCode.DOWN:
                  break;
               case NavigationCode.GAMEPAD_B:
                  this.onBPressed();
                  param1.handled = true;
            }
         }
      }
      
      protected function onBPressed(param1:InputDetails = null) : void
      {
         this.closeList(TripContainer.CANCELLED_INDEX);
      }
      
      private function closeList(param1:int) : *
      {
         dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,param1));
         if(!this.bStayOpenOnSelection)
         {
            this.bOpen = false;
         }
         if(param1 == TripContainer.CANCELLED_INDEX)
         {
            this.selectedIndex = this._startingIndex;
         }
         if(this.associatedButton)
         {
            if(this.bManagerUsingGamepad && !MenuManager.manager.bPopUpOpen)
            {
               FocusManager.setFocus(this.associatedButton);
            }
         }
         if(FocusManager.getModalClip() == this)
         {
            FocusManager.setModalClip(null);
         }
      }
      
      function onOpen(param1:Boolean = true) : void
      {
         if(param1)
         {
            FocusManager.setModalClip(this);
         }
         TripList.onOpen(this,this.bManagerUsingGamepad);
      }
      
      function onClose(param1:Event = null) : void
      {
         TripList.onClose(this);
         if(FocusManager.getModalClip() == this)
         {
            FocusManager.setModalClip(null);
         }
      }
   }
}
