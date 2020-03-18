package tripwire.popups
{
   import tripwire.containers.TripContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import tripwire.managers.MenuManager;
   import scaleform.gfx.FocusManager;
   import scaleform.clik.ui.InputDetails;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   import scaleform.clik.events.ButtonEvent;
   import flash.external.ExternalInterface;
   
   public class BasePopup extends TripContainer
   {
       
      
      protected var _prevModalClip:Sprite;
      
      public var bPartyWasFocused:Boolean;
      
      public function BasePopup()
      {
         super();
         enableInitCallback = true;
         this.openPopup();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         bSelected = true;
         super.addedToStage(param1);
         this.setTabIndex();
      }
      
      public function setTabIndex() : void
      {
      }
      
      public function set descriptionText(param1:String) : void
      {
      }
      
      public function setPopupText(param1:String, param2:String, param3:String, param4:String, param5:String) : *
      {
      }
      
      public function openPopup() : void
      {
         if(!_bOpen)
         {
            this.bPartyWasFocused = MenuManager.manager.bPartyWidgetFocused;
            MenuManager.manager.bPartyWidgetFocused = false;
            this.openAnimation();
            _bOpen = true;
            this._prevModalClip = FocusManager.getModalClip();
            FocusManager.setModalClip(this);
         }
      }
      
      override protected function onBPressed(param1:InputDetails) : void
      {
         super.onBPressed(param1);
         this.closePopup();
      }
      
      override protected function openAnimation(param1:Boolean = true) : *
      {
         TweenMax.fromTo(this,6,{
            "z":-128,
            "autoAlpha":0
         },{
            "visible":true,
            "z":0,
            "autoAlpha":(!!param1?_defaultAlpha:_dimmedAlpha),
            "ease":Cubic.easeOut,
            "useFrames":true,
            "onComplete":onOpened
         });
      }
      
      public function onClosePopup(param1:ButtonEvent) : void
      {
         if(_bOpen)
         {
            TweenMax.fromTo(this,6,{
               "z":0,
               "alpha":1
            },{
               "visible":false,
               "z":-128,
               "alpha":0,
               "ease":Cubic.easeOut,
               "useFrames":true,
               "onComplete":this.closePopup
            });
            FocusManager.setModalClip(this._prevModalClip);
            _bOpen = false;
         }
      }
      
      public function closePopup() : void
      {
         ExternalInterface.call("Callback_ClosedPopup");
      }
   }
}
