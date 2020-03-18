package tripwire.controls
{
   import scaleform.clik.controls.ListItemRenderer;
   import tripwire.managers.MenuManager;
   import scaleform.gfx.Extensions;
   import flash.events.MouseEvent;
   
   public class TripListItemRenderer extends ListItemRenderer
   {
       
      
      public var clickSoundEffect:String = "SHARED_BUTTON_CLICK";
      
      public var overSoundEffect:String = "TITLE_BUTTON_ROLLOVER";
      
      public var highlightColor:uint = 16503487;
      
      public var defaultColor:uint = 12234399;
      
      public var disabledColor:uint = 8743272;
      
      public function TripListItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(param1 != null)
         {
            if(param1 as String == null)
            {
               label = !!param1.label?param1.label:"";
            }
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      public function get bManagerUsingGamepad() : Boolean
      {
         if(MenuManager.manager != null)
         {
            return MenuManager.manager.bUsingGamepad;
         }
         return false;
      }
      
      override protected function handlePress(param1:uint = 0) : void
      {
         super.handlePress(param1);
         if(Extensions.gfxProcessSound != null && enabled == true)
         {
            Extensions.gfxProcessSound(this,"UI",this.clickSoundEffect);
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         if(Extensions.gfxProcessSound != null && enabled == true)
         {
            Extensions.gfxProcessSound(this,"UI",this.clickSoundEffect);
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(!selected)
         {
            this.highlightButton();
            if(Extensions.gfxProcessSound != null && enabled == true)
            {
               Extensions.gfxProcessSound(this,"UI",this.overSoundEffect);
            }
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         if(!selected)
         {
            this.unhighlightButton();
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(param1 && super.selected == false)
         {
            this.highlightButton();
            if(Extensions.gfxProcessSound != null && enabled == true && this.bManagerUsingGamepad)
            {
               Extensions.gfxProcessSound(this,"UI",this.overSoundEffect);
            }
         }
         else if(!param1)
         {
            this.unhighlightButton();
         }
         super.selected = param1;
      }
      
      protected function highlightButton() : *
      {
         if(textField != null)
         {
            textField.textColor = this.highlightColor;
         }
      }
      
      protected function unhighlightButton() : *
      {
         if(textField != null)
         {
            textField.textColor = this.defaultColor;
         }
      }
   }
}
