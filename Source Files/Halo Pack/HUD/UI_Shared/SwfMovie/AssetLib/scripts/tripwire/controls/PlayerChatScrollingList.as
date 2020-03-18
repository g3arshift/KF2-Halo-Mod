package tripwire.controls
{
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.DataProvider;
   import flash.display.MovieClip;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   
   public class PlayerChatScrollingList extends ScrollingList
   {
       
      
      public var ChatHistoryDP:DataProvider;
      
      public var ChatHistoryBackground:MovieClip;
      
      public var renderer:tripwire.controls.PlayerChatLineRenderer;
      
      public var inputTextFieldHeight:Number;
      
      private var newColor:Number;
      
      public var ChatScrollBar:ScrollBar;
      
      public var bEnableMouseWheelScroll:Boolean;
      
      public function PlayerChatScrollingList()
      {
         this.ChatHistoryDP = new DataProvider();
         super();
         dataProvider = this.ChatHistoryDP;
      }
      
      public function addChatMessage(param1:String, param2:String) : *
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc3_:Date = new Date();
         var _loc4_:Number = 16777215;
         if(param2 != "")
         {
            _loc4_ = uint("0x" + param2);
         }
         this.newColor = _loc4_;
         this.ChatHistoryDP.unshift({
            "label":param1,
            "messageClr":_loc4_,
            "timeStamp":_loc3_.getTime()
         });
         invalidateData();
         if(!this.ChatHistoryBackground.visible)
         {
            selectedIndex = 0;
            scrollToIndex(selectedIndex);
         }
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc1_ - 1 - _loc7_);
            _loc8_.x = _loc4_;
            _loc8_.y = height - _loc8_.height * (_loc1_ - 1 - _loc7_) - _loc5_ - this.inputTextFieldHeight;
            _loc8_.width = _loc3_;
            _loc8_.height = PlayerChatLineRenderer(_loc8_).textField.height;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      override protected function createScrollBar() : void
      {
         super.createScrollBar();
         if(scrollBar != null)
         {
            scrollBar.visible = this.ChatHistoryBackground.visible;
         }
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(this.bEnableMouseWheelScroll)
         {
            scrollBar.position = scrollBar.position + (param1.delta > 0?1:-1) * 1;
         }
      }
      
      public function setShowHistory(param1:Boolean) : *
      {
         var _loc2_:tripwire.controls.PlayerChatLineRenderer = null;
         if(scrollBar)
         {
            scrollBar.visible = param1;
         }
         if(param1)
         {
            stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false,0,true);
         }
         else
         {
            stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
         }
         this.ChatHistoryBackground.visible = param1;
         for each(_loc2_ in _renderers)
         {
            _loc2_.bHistoryIsOpen = param1;
            _loc2_.onChatWindowToggle(param1);
         }
      }
   }
}
