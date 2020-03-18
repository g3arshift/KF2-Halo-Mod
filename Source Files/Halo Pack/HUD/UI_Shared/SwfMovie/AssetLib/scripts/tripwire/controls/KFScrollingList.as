package tripwire.controls
{
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.events.IndexEvent;
   
   public class KFScrollingList extends ScrollingList
   {
       
      
      private var _type:String;
      
      public function KFScrollingList()
      {
         super();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.GAMEPAD_A:
                  this.onAPressed(_loc2_);
                  break;
               case NavigationCode.GAMEPAD_B:
                  this.onBPressed(_loc2_);
            }
         }
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void
      {
         super.handleItemClick(param1);
         this.CloseList((param1.currentTarget as IListItemRenderer).index);
      }
      
      protected function onAPressed(param1:InputDetails) : void
      {
         this.CloseList(selectedIndex);
      }
      
      protected function onBPressed(param1:InputDetails) : void
      {
         this.CloseList(-1);
      }
      
      function CloseList(param1:int) : *
      {
         dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,param1));
      }
   }
}
