package tripwire.controls
{
   import scaleform.clik.controls.DropdownMenu;
   import tripwire.managers.MenuManager;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import flash.events.MouseEvent;
   import scaleform.gfx.Extensions;
   
   public class TripDropDownMenu extends DropdownMenu
   {
       
      
      public function TripDropDownMenu()
      {
         super();
         preventAutosizing = true;
      }
      
      public function get bManagerUsingGamepad() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bUsingGamepad;
         }
         return false;
      }
      
      override protected function showDropdown() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         if(dropdown == null)
         {
            return;
         }
         if(dropdown is String && dropdown != "")
         {
            _loc2_ = getDefinitionByName(dropdown.toString()) as Class;
            if(_loc2_ != null)
            {
               _loc1_ = new _loc2_() as CoreList;
            }
         }
         if(_loc1_)
         {
            if(itemRenderer is String && itemRenderer != "")
            {
               _loc1_.itemRenderer = getDefinitionByName(itemRenderer.toString()) as Class;
            }
            else if(itemRenderer is Class)
            {
               _loc1_.itemRenderer = itemRenderer as Class;
            }
            if(scrollBar is String && scrollBar != "")
            {
               _loc1_.scrollBar = getDefinitionByName(scrollBar.toString()) as Class;
            }
            else if(scrollBar is Class)
            {
               _loc1_.scrollBar = scrollBar as Class;
            }
            if(this.bManagerUsingGamepad)
            {
               _loc1_.selectedIndex = _selectedIndex;
            }
            _loc1_.width = menuWidth == -1?Number(width + menuOffset.left + menuOffset.right):Number(menuWidth);
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset = {
               "top":thumbOffsetTop,
               "bottom":thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1?5:menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.addEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false,0,true);
            _dropdownRef = _loc1_;
            parent.addChild(_loc1_);
            _loc1_.x = x + menuOffset.left;
            _loc1_.y = menuDirection == "down"?Number(y + height + menuOffset.top):Number(y - _dropdownRef.height + menuOffset.bottom);
            _loc1_.bDropDown = true;
         }
      }
      
      override public function itemToLabel(param1:Object) : String
      {
         if(_labelFunction != null)
         {
            return _labelFunction(param1);
         }
         if(param1 == null)
         {
            return "";
         }
         if(param1 is String)
         {
            return param1.toString();
         }
         if(_labelField != null && param1[_labelField] != null)
         {
            return param1[_labelField];
         }
         return param1.toString();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         var _loc3_:* = _loc2_.value == InputValue.KEY_DOWN;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ESCAPE:
               if(selected)
               {
                  if(_loc3_)
                  {
                     close();
                  }
                  param1.handled = true;
               }
            case NavigationCode.GAMEPAD_B:
               if(selected)
               {
                  if(_loc3_)
                  {
                     close();
                  }
                  param1.handled = true;
                  break;
               }
            default:
               if(selected)
               {
                  if(_loc3_)
                  {
                     close();
                  }
                  param1.handled = true;
                  break;
               }
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         if(Extensions.gfxProcessSound != null)
         {
            Extensions.gfxProcessSound(this,"ButtonSoundTheme","Button_Selected");
         }
      }
      
      override protected function handlePress(param1:uint = 0) : void
      {
         super.handlePress(param1);
         if(Extensions.gfxProcessSound != null)
         {
            Extensions.gfxProcessSound(this,"ButtonSoundTheme","Button_Selected");
         }
      }
   }
}
