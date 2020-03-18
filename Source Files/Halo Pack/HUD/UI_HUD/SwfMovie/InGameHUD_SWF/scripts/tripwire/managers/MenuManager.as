package tripwire.managers
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.display.Loader;
   import tripwire.containers.TripContainer;
   import tripwire.popups.BasePopup;
   import flash.display.Sprite;
   import flash.events.Event;
   import scaleform.gfx.FocusManager;
   import scaleform.clik.core.CLIK;
   import flash.net.URLRequest;
   import flash.events.IOErrorEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import flash.external.ExternalInterface;
   import flash.events.MouseEvent;
   import flash.display.StageScaleMode;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   
   public class MenuManager extends UIComponent
   {
      
      private static var _manager:tripwire.managers.MenuManager;
      
      public static var INPUT_CHANGED:String = "INPUT_CHANGED";
      
      public static var PROMPT_CHANGED:String = "PROMPT_CHANGED";
      
      public static var PARTYFOCUS_CHANGED:String = "PARTYFOCUS_CHANGED";
       
      
      public var mCursor:MovieClip;
      
      public var renderTexture:MovieClip;
      
      public var renderTexture_IIS:MovieClip;
      
      public var MenuBackground:MovieClip;
      
      public var MenuScanlines:MovieClip;
      
      private const MenuLayer = 2;
      
      private const WidgetLayer = 3;
      
      private var _menuLoader:Loader;
      
      private var _popupLoader:Loader;
      
      private var _widgetLoader:Loader;
      
      public var bStartUpGamma:Boolean = false;
      
      public var bPopUpOpen:Boolean;
      
      private var _bLoading:Boolean;
      
      private var _bUsingGamepad:Boolean;
      
      private var _bConsoleBuild:Boolean;
      
      private var _bOpenedInGame:Boolean;
      
      private var _bMenuOpen:Boolean;
      
      private var _bWidgetsVisible:Boolean;
      
      private var _currentURL:String;
      
      private var _widgets:Vector.<TripContainer>;
      
      private var _currentMenu:MovieClip;
      
      private var _currentMenuIndex:int;
      
      private var _pendingPopupTitle:String;
      
      private var _pendingPopupDescription:String;
      
      private var _pendingPopupLeftButtonString:String;
      
      private var _pendingPopupRightButtonString:String;
      
      private var _pendingPopupMiddleButtonString:String;
      
      private var _currentPopUp:BasePopup;
      
      private var _numPrompts:int = 2;
      
      private var CachedModalClip:Sprite;
      
      public var bPartyWidgetFocused:Boolean = true;
      
      private var menuList:Array;
      
      public function MenuManager()
      {
         super();
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         this.initializeManager();
         this.setMenuVisibility(true);
         var _loc1_:PerspectiveProjection = new PerspectiveProjection();
         _loc1_.fieldOfView = 30;
         _loc1_.projectionCenter = new Point(960,540);
         stage.transform.perspectiveProjection = _loc1_;
         addChild(this.MenuScanlines);
         this.MenuScanlines.mouseEnabled = false;
         this.MenuScanlines.mouseChildren = false;
         this.MenuBackground.addEventListener("menuClosed",this.onMenuClosed,false,0,true);
      }
      
      public static function get manager() : tripwire.managers.MenuManager
      {
         return _manager;
      }
      
      public function set backgroundVisible(param1:Boolean) : void
      {
         this.renderTexture.visible = param1;
      }
      
      public function set IISMovieVisible(param1:Boolean) : void
      {
         this.renderTexture_IIS.visible = param1;
      }
      
      public function get bUsingGamepad() : Boolean
      {
         return this._bUsingGamepad;
      }
      
      public function set bUsingGamepad(param1:Boolean) : void
      {
         if(!this._bConsoleBuild)
         {
            if(this._bUsingGamepad != param1)
            {
               this._bUsingGamepad = param1;
               if(stage != null)
               {
                  stage.dispatchEvent(new Event(INPUT_CHANGED));
               }
               this.controllerEnableWidgets(false);
               if(this.bPopUpOpen && this._currentPopUp != null)
               {
                  this._currentPopUp.openPopup();
               }
               else if(this.menuList.length > this._currentMenuIndex)
               {
                  this.menuList[this._currentMenuIndex].menuObject.selectContainer();
               }
               this.mCursor.visible = !this._bUsingGamepad;
               if(!this._bUsingGamepad)
               {
                  FocusManager.setFocus(null);
               }
            }
         }
      }
      
      public function get bConsoleBuild() : Boolean
      {
         return this._bConsoleBuild;
      }
      
      public function set bConsoleBuild(param1:Boolean) : *
      {
         if(this._bConsoleBuild != param1)
         {
            this.bUsingGamepad = param1;
            this._bConsoleBuild = param1;
         }
      }
      
      public function get bOpenedInGame() : Boolean
      {
         return this._bOpenedInGame;
      }
      
      public function set bOpenedInGame(param1:Boolean) : *
      {
         if(this._bOpenedInGame == param1)
         {
            return;
         }
         this._bOpenedInGame = param1;
         if(this._bOpenedInGame)
         {
            this.numPrompts = 2;
         }
         else
         {
            this.numPrompts = this.menuList.length > this._currentMenuIndex && this.menuList[this._currentMenuIndex].menuObject != null?int(this.menuList[this._currentMenuIndex].menuObject.defaultNumPrompts):1;
         }
      }
      
      public function get numPrompts() : int
      {
         return this._numPrompts;
      }
      
      public function set numPrompts(param1:int) : *
      {
         if(this._numPrompts == param1)
         {
            return;
         }
         this._numPrompts = !this.bOpenedInGame?int(param1):2;
         stage.dispatchEvent(new Event(PROMPT_CHANGED));
      }
      
      public function loadCurrentMenu(param1:String, param2:Boolean) : void
      {
         if(this._bLoading)
         {
            return;
         }
         this._bWidgetsVisible = param2;
         var _loc3_:int = 0;
         while(_loc3_ < this.menuList.length)
         {
            if(this.menuList[_loc3_].URL == param1)
            {
               this.menuList[this._currentMenuIndex].menuObject.closeContainer();
               this.menuList[_loc3_].menuObject.openContainer();
               this.menuList[_loc3_].menuObject.enableInitCallback = true;
               CLIK.queueInitCallback(this.menuList[_loc3_].menuObject);
               this._currentMenuIndex = _loc3_;
               this.setMenuVisibility(true);
               this.setFocusBackToMenu();
               return;
            }
            _loc3_++;
         }
         this._menuLoader.load(new URLRequest(param1));
         this._currentURL = param1;
         this._bLoading = true;
      }
      
      public function loadWidgets(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this._widgetLoader.load(new URLRequest(param1[_loc2_]));
            _loc2_++;
         }
      }
      
      public function widgetLoaderComplete(param1:Event) : void
      {
         var _loc2_:TripContainer = param1.target.content.getChildAt(0) as TripContainer;
         this._widgets.push(_loc2_);
         stage.addChildAt(_loc2_,stage.numChildren - 1);
         _loc2_.openContainer();
         _loc2_.deselectContainer();
      }
      
      public function loadCurrentPopup(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this._pendingPopupTitle = param2;
         this._pendingPopupDescription = param3;
         this._pendingPopupLeftButtonString = param4;
         this._pendingPopupMiddleButtonString = param6;
         this._pendingPopupRightButtonString = param5;
         this._popupLoader.load(new URLRequest(param1));
         if(this.menuList.length > this._currentMenuIndex)
         {
            this.menuList[this._currentMenuIndex].menuObject.focusGroupOut();
         }
         this.bPopUpOpen = true;
      }
      
      protected function loaderComplete(param1:Event) : void
      {
         if(this._currentMenuIndex < this.menuList.length)
         {
            if(this.menuList[this._currentMenuIndex] != null)
            {
               this.menuList[this._currentMenuIndex].menuObject.closeContainer();
            }
         }
         var _loc2_:Object = new Object();
         _loc2_.URL = this._currentURL;
         _loc2_.menuObject = param1.target.content.getChildAt(0) as TripContainer;
         this.menuList.push(_loc2_);
         this._currentMenuIndex = this.menuList.length - 1;
         this.bPartyWidgetFocused = true;
         this.setMenuVisibility(true);
         if(!this.bPopUpOpen)
         {
            this.setFocusBackToMenu();
         }
         this.controllerEnableWidgets(false);
         stage.addChildAt(_loc2_.menuObject,this.MenuLayer);
         this._bLoading = false;
      }
      
      protected function popupLoaderComplete(param1:Event) : void
      {
         this._currentPopUp = param1.target.content.getChildAt(0) as BasePopup;
         stage.addChild(param1.target.content);
         this._currentPopUp.setPopupText(this._pendingPopupTitle,this._pendingPopupDescription,this._pendingPopupLeftButtonString,this._pendingPopupRightButtonString,this._pendingPopupMiddleButtonString);
         this.mCursor.visible = !this.bUsingGamepad;
         if(!this._bMenuOpen)
         {
            stage.removeChild(this.mCursor);
            stage.addChild(this.mCursor);
            this.setMenuEvents(true);
         }
      }
      
      public function unloadCurrentPopup() : void
      {
         this._currentPopUp = null;
         if(this._popupLoader != null)
         {
            this._popupLoader.unloadAndStop();
            this._pendingPopupTitle = "";
            this._pendingPopupDescription = "";
            this._pendingPopupLeftButtonString = "";
            this._pendingPopupRightButtonString = "";
         }
         if(!this._bMenuOpen)
         {
            this.mCursor.visible = false;
            this.setMenuEvents(false);
         }
         this.bPopUpOpen = false;
         if(this.menuList != null && this.menuList[this._currentMenuIndex] != null && this.menuList[this._currentMenuIndex].menuObject != null)
         {
            this.menuList[this._currentMenuIndex].menuObject.focusGroupIn();
         }
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
      }
      
      protected function initializeManager() : void
      {
         _manager = this;
         _enableInitCallback = true;
         this.mCursor.mouseEnabled = false;
         this.mCursor.tabEnabled = false;
         this.menuList = new Array();
         this._menuLoader = new Loader();
         this._menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderComplete);
         this._menuLoader.addEventListener(IOErrorEvent.IO_ERROR,this.loadError);
         this._menuLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.contentLoadError);
         this._widgets = new Vector.<TripContainer>();
         this._widgetLoader = new Loader();
         this._widgetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.widgetLoaderComplete);
         this._popupLoader = new Loader();
         this._popupLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.popupLoaderComplete);
      }
      
      protected function contentLoadError(param1:IOErrorEvent) : void
      {
         trace("CONTENT LOAD ERROR: " + param1.toString());
      }
      
      protected function loadError(param1:IOErrorEvent) : void
      {
         trace("LOAD ERROR: " + param1.toString());
      }
      
      protected function handleControllerInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(this._bWidgetsVisible && _loc2_.value == InputValue.KEY_DOWN && !this.bPopUpOpen)
         {
            switch(param1.details.navEquivalent)
            {
               case NavigationCode.GAMEPAD_BACK:
                  if(this.bUsingGamepad && this._widgets[0].visible)
                  {
                     this.togglePartyWidgetFocus();
                  }
            }
         }
      }
      
      public function togglePartyWidgetFocus() : *
      {
         if(this.bPartyWidgetFocused)
         {
            this.setFocusBackToMenu();
         }
         else
         {
            this.setFocusToPartyWidget();
         }
      }
      
      public function setFocusToPartyWidget() : void
      {
         this.CachedModalClip = FocusManager.getModalClip(0);
         FocusManager.setModalClip(null,0);
         this.menuList[this._currentMenuIndex].menuObject.focusGroupOut();
         this.controllerEnableWidgets(true);
         this.CachedModalClip = null;
      }
      
      public function setFocusBackToMenu(param1:Boolean = false) : void
      {
         if(this.CachedModalClip != null)
         {
            FocusManager.setModalClip(this.CachedModalClip,0);
         }
         this.menuList[this._currentMenuIndex].menuObject.focusGroupIn();
         this.controllerEnableWidgets(false);
      }
      
      public function setWidgetsVisiblity(param1:Boolean) : void
      {
         trace("BRIAN:: [" + this + "] value: " + param1);
         trace("BRIAN:: [" + this + "] _widgets.length: " + this._widgets.length);
         var _loc2_:int = 0;
         while(_loc2_ < this._widgets.length)
         {
            if(param1)
            {
               this._widgets[_loc2_].openContainer();
            }
            else
            {
               this._widgets[_loc2_].closeContainer();
            }
            _loc2_++;
         }
      }
      
      public function setMenuVisibility(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1 && !this._bMenuOpen)
         {
            this.MenuBackground.gotoAndPlay("open");
            this.MenuBackground.visible = true;
         }
         else if(!param1 && this._bMenuOpen)
         {
            this.MenuBackground.gotoAndPlay("close");
         }
         this._bMenuOpen = param1;
         this.setMenuEvents(param1);
         if(this._bWidgetsVisible)
         {
            _loc2_ = 0;
            while(_loc2_ < this._widgets.length)
            {
               if(param1)
               {
                  this._widgets[_loc2_].openContainer();
               }
               else
               {
                  this._widgets[_loc2_].closeContainer();
               }
               _loc2_++;
            }
         }
         else if(this._bMenuOpen)
         {
            _loc2_ = 0;
            while(_loc2_ < this._widgets.length)
            {
               this._widgets[_loc2_].closeContainer();
               _loc2_++;
            }
         }
         if(this._currentMenuIndex < this.menuList.length)
         {
            if(param1)
            {
               this.menuList[this._currentMenuIndex].menuObject.openContainer();
            }
            else
            {
               this.menuList[this._currentMenuIndex].menuObject.closeContainer();
            }
         }
         if(this.bPopUpOpen && this._currentPopUp != null)
         {
            this._currentPopUp.closePopup();
         }
         this.mCursor.visible = param1 && !this.bUsingGamepad;
         this.MenuScanlines.visible = param1;
         this.mCursor.x = mouseX;
         this.mCursor.y = mouseY;
      }
      
      public function onMenuClosed() : void
      {
         if(!this._bMenuOpen)
         {
            this.MenuBackground.visible = false;
            if(this._currentMenuIndex < this.menuList.length)
            {
               this.menuList[this._currentMenuIndex].menuObject.visible = false;
            }
            ExternalInterface.call("Callback_MenusFinishedClosing");
         }
      }
      
      public function setMenuEvents(param1:Boolean) : void
      {
         if(param1)
         {
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
            stage.addEventListener(Event.ADDED,this.changeMouseLayer,false,0,true);
            stage.addEventListener(InputEvent.INPUT,this.handleControllerInput,false,0,true);
         }
         else
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
            stage.removeEventListener(Event.ADDED,this.changeMouseLayer);
            stage.removeEventListener(InputEvent.INPUT,this.handleControllerInput);
         }
      }
      
      public function currentFocus() : void
      {
         trace("Bryan: MenuManager currentFocus:: " + FocusManager.getFocus());
         trace("Bryan: MenuManager modalClip:: " + FocusManager.getModalClip());
      }
      
      protected function controllerEnableWidgets(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this.bPartyWidgetFocused != param1)
         {
            this.bPartyWidgetFocused = !this.bPartyWidgetFocused;
            _loc2_ = 0;
            while(_loc2_ < this._widgets.length)
            {
               if(param1)
               {
                  this._widgets[_loc2_].selectContainer();
                  this.menuList[this._currentMenuIndex].menuObject.alpha = 0.6;
               }
               else
               {
                  this._widgets[_loc2_].deselectContainer();
                  this.menuList[this._currentMenuIndex].menuObject.alpha = 1;
               }
               _loc2_++;
            }
         }
      }
      
      protected function handleMouseMove(param1:MouseEvent) : void
      {
         this.mCursor.x = param1.stageX;
         this.mCursor.y = param1.stageY;
      }
      
      protected function changeMouseLayer(param1:Event) : void
      {
         if(param1.target != this.mCursor)
         {
            stage.removeChild(this.mCursor);
            stage.addChild(this.mCursor);
         }
      }
      
      private function testMenus() : void
      {
         var _loc1_:Array = new Array("../UI_Widgets/PartyWidget_SWF.swf","../UI_Widgets/MenuBarWidget_SWF.swf");
         this.loadWidgets(_loc1_);
         this.loadCurrentMenu("../UI_Menus/GearMenu_SWF.swf",false);
      }
   }
}
