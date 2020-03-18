package tripwire.containers
{
   import scaleform.clik.core.UIComponent;
   import tripwire.managers.MenuManager;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;
   import com.greensock.TweenMax;
   import scaleform.gfx.Extensions;
   import flash.events.FocusEvent;
   import scaleform.clik.managers.FocusHandler;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import flash.events.MouseEvent;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Cubic;
   import com.greensock.events.TweenEvent;
   
   public class TripContainer extends UIComponent
   {
      
      public static const CANCELLED_INDEX:int = -1;
       
      
      public var currentElement:UIComponent;
      
      public var defaultFirstElement:UIComponent;
      
      public var defaultNumPrompts:int = 1;
      
      protected var _bOpen:Boolean = false;
      
      protected var _bReadyForInput:Boolean = false;
      
      protected var _defaultAlpha:Number;
      
      protected var _dimmedAlpha:Number = 0.6;
      
      protected const ANIM_TIME = 4;
      
      protected const AnimBLUR_OUT = 0;
      
      protected const ANIM_START_Z = 0;
      
      protected const ANIM_OFFSET_Z = 48;
      
      protected const ANIM_BLUR_X = 24;
      
      protected const ANIM_BLUR_Y = 16;
      
      protected const ANIM_ALPHA = 0;
      
      protected const SUBCONTAINER_ANIM_START_Z = 0;
      
      protected const SUBCONATINER_ANIM_OFFSET_Z = -128;
      
      protected const SUBCONTAINER_ANIM_BLUR_X = 12;
      
      protected const SUBCONTAINER_ANIM_BLUR_Y = 12;
      
      public var ANIM_START_X:Number;
      
      public var ANIM_OFFSET_X:Number = -24;
      
      public var bSelected:Boolean = false;
      
      public var sectionHeader:tripwire.containers.SectionHeaderContainer;
      
      public var rightSidePanels:Array;
      
      public var leftSidePanels:Array;
      
      private var _bBlockContainerFocus:Boolean = false;
      
      public var openSoundEffect:String = "";
      
      public var closeSoundEffect:String = "";
      
      public function TripContainer()
      {
         this.rightSidePanels = new Array();
         this.leftSidePanels = new Array();
         super();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         enableInitCallback = true;
         focused = 0;
         this._defaultAlpha = alpha;
      }
      
      public function get bManagerUsingGamepad() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bUsingGamepad;
         }
         return false;
      }
      
      public function get bManagerConsoleBuild() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bConsoleBuild;
         }
         return false;
      }
      
      public function get bManagerPopUpOpen() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bPopUpOpen;
         }
         return false;
      }
      
      public function set containerDisplayPrompts(param1:int) : void
      {
         if(MenuManager.manager != null && MenuManager.manager.numPrompts != param1)
         {
            MenuManager.manager.numPrompts = param1;
         }
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.ANIM_START_X = x;
         if(this.bSelected)
         {
            stage.addEventListener(MenuManager.INPUT_CHANGED,this.onInputChange,false,0,true);
            stage.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         }
      }
      
      public function get bOpen() : Boolean
      {
         return this._bOpen;
      }
      
      public function get bBlockContainerFocus() : Boolean
      {
         return this._bBlockContainerFocus;
      }
      
      public function set bBlockContainerFocus(param1:Boolean) : void
      {
         if(param1 == this._bBlockContainerFocus)
         {
            return;
         }
         this._bBlockContainerFocus = param1;
      }
      
      public function openContainer(param1:Boolean = true) : void
      {
         if(!this._bOpen)
         {
            if(this.currentElement == null && this.bManagerUsingGamepad && this.defaultFirstElement)
            {
               this.currentElement = this.defaultFirstElement;
            }
            if(stage)
            {
               stage.addEventListener(MenuManager.INPUT_CHANGED,this.onInputChange,false,0,true);
            }
            this.selectContainer();
            if(isNaN(this.ANIM_START_X))
            {
               this.alpha = 0;
               TweenMax.to(this,1,{
                  "useFrames":true,
                  "onComplete":this.openAnimation,
                  "onCompleteParams":[param1]
               });
            }
            else
            {
               this.alpha = 0;
               this.openAnimation(param1);
            }
            if(Extensions.gfxProcessSound != null)
            {
               Extensions.gfxProcessSound(this,"UI",this.openSoundEffect);
            }
            this._bOpen = true;
         }
      }
      
      public function selectContainer() : void
      {
         visible = true;
         tabEnabled = true;
         tabChildren = true;
         this.bSelected = true;
         addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn,false,0,true);
         if(stage)
         {
            stage.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         }
         if(this.bManagerUsingGamepad && this.currentElement && !MenuManager.manager.bPopUpOpen && this.currentElement.visible)
         {
            this.currentElement.tabEnabled = true;
            this.currentElement.tabChildren = true;
            FocusHandler.getInstance().setFocus(this.currentElement);
         }
         if(this.sectionHeader != null)
         {
            this.sectionHeader.controllerIconVisible = !this.bSelected;
         }
         this.containerDisplayPrompts = this.defaultNumPrompts;
      }
      
      public function closeContainer() : void
      {
         if(this._bOpen)
         {
            this._bOpen = false;
            this.deselectContainer();
            this.closeAnimation();
            stage.removeEventListener(MenuManager.INPUT_CHANGED,this.onInputChange);
            mouseChildren = mouseEnabled = false;
            if(this.currentElement)
            {
               this.currentElement = null;
            }
            if(Extensions.gfxProcessSound != null)
            {
               Extensions.gfxProcessSound(this,"UI",this.closeSoundEffect);
            }
         }
      }
      
      public function deselectContainer() : void
      {
         tabEnabled = false;
         tabChildren = false;
         this.bSelected = false;
         removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         if(stage)
         {
            stage.removeEventListener(InputEvent.INPUT,this.handleInput);
         }
         if(this.currentElement)
         {
            this.currentElement.focused = 0;
         }
         if(this.sectionHeader != null && this.bOpen)
         {
            this.sectionHeader.controllerIconVisible = !this.bSelected;
         }
      }
      
      public function focusGroupIn() : void
      {
         var _loc1_:* = visible;
         this.selectContainer();
         visible = _loc1_;
      }
      
      public function focusGroupOut() : void
      {
         this.deselectContainer();
      }
      
      public function pushToBackground() : void
      {
         if(this._bOpen)
         {
            this.deselectContainer();
            this.pushToBackAnimation();
            this._bOpen = false;
         }
      }
      
      public function onFocusIn(param1:FocusEvent) : *
      {
         if(this.bManagerUsingGamepad)
         {
            this.currentElement = param1.target as UIComponent;
         }
      }
      
      protected function onInputChange(param1:Event) : *
      {
         if(!this.bManagerUsingGamepad)
         {
            this.unDimSides();
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         if(!this._bReadyForInput)
         {
            return;
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.GAMEPAD_B:
                  if(_loc2_.code == 97)
                  {
                     this.onBPressed(_loc2_);
                  }
            }
         }
      }
      
      protected function onBPressed(param1:InputDetails) : void
      {
      }
      
      public function dimLeftSide(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this.leftSidePanels.length > 0 && this.bManagerUsingGamepad)
         {
            _loc2_ = 0;
            while(_loc2_ < this.leftSidePanels.length)
            {
               if(param1)
               {
                  this.leftSidePanels[_loc2_].alpha = this._dimmedAlpha;
               }
               else
               {
                  this.leftSidePanels[_loc2_].alpha = this._defaultAlpha;
               }
               _loc2_++;
            }
         }
      }
      
      public function dimRightSide(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this.rightSidePanels.length > 0 && this.bManagerUsingGamepad)
         {
            _loc2_ = 0;
            while(_loc2_ < this.rightSidePanels.length)
            {
               if(param1)
               {
                  this.rightSidePanels[_loc2_].alpha = this._dimmedAlpha;
               }
               else
               {
                  this.rightSidePanels[_loc2_].alpha = this._defaultAlpha;
               }
               _loc2_++;
            }
         }
      }
      
      public function showDimLeftSide(param1:Boolean) : *
      {
         this.dimLeftSide(param1);
         this.dimRightSide(!param1);
      }
      
      public function handleLeftSideOver(param1:MouseEvent) : void
      {
         this.showDimLeftSide(false);
      }
      
      public function handleRightSideOver(param1:MouseEvent) : void
      {
         this.showDimLeftSide(true);
      }
      
      public function unDimSides() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.leftSidePanels.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.leftSidePanels.length)
            {
               this.leftSidePanels[_loc1_].alpha = this._defaultAlpha;
               _loc1_++;
            }
         }
         if(this.rightSidePanels.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.rightSidePanels.length)
            {
               this.rightSidePanels[_loc2_].alpha = this._defaultAlpha;
               _loc2_++;
            }
         }
      }
      
      protected function openAnimation(param1:Boolean = true) : *
      {
         if(!this.bManagerUsingGamepad)
         {
            param1 = true;
         }
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,this.ANIM_TIME,{
            "z":this.ANIM_OFFSET_Z,
            "alpha":0,
            "ease":Linear.easeNone,
            "useFrames":true
         },{
            "z":this.ANIM_START_Z,
            "alpha":(!!param1?this._defaultAlpha:this._dimmedAlpha),
            "ease":Linear.easeNone,
            "delay":this.ANIM_TIME,
            "useFrames":true,
            "onComplete":this.onOpened
         });
      }
      
      protected function closeAnimation() : *
      {
         if(!MenuManager.manager.bPartyWidgetFocused)
         {
            FocusHandler.getInstance().setFocus(null);
         }
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,this.ANIM_TIME,{
            "z":this.ANIM_START_Z,
            "alpha":alpha,
            "ease":Linear.easeNone,
            "useFrames":true
         },{
            "z":this.ANIM_OFFSET_Z,
            "alpha":0,
            "ease":Linear.easeNone,
            "useFrames":true,
            "onComplete":this.onClosed
         });
      }
      
      protected function pushToBackAnimation() : *
      {
         TweenMax.fromTo(this,this.ANIM_TIME,{
            "z":this.ANIM_START_Z,
            "alpha":alpha,
            "ease":Cubic.easeOut,
            "useFrames":true
         },{
            "z":this.ANIM_OFFSET_Z,
            "alpha":0.64 * this.ANIM_ALPHA,
            "ease":Cubic.easeOut,
            "useFrames":true
         });
      }
      
      protected function onOpened(param1:TweenEvent = null) : void
      {
         mouseChildren = mouseEnabled = true;
         this._bReadyForInput = true;
         play();
      }
      
      protected function onClosed(param1:TweenEvent = null) : void
      {
         this._bReadyForInput = false;
         visible = false;
         this._bOpen = false;
         stop();
      }
   }
}
