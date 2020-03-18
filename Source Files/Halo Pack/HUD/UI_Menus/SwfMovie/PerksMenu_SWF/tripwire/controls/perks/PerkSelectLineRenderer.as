package tripwire.controls.perks
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   import tripwire.controls.TripListItemRenderer;
   import tripwire.controls.TripUILoaderQueue;
   
   public class PerkSelectLineRenderer extends TripListItemRenderer
   {
       
      
      public var iconLoader:TripUILoaderQueue;
      
      public var perkLevelText:TextField;
      
      public var tierBG:MovieClip;
      
      public var bTierUnlocked:Boolean;
      
      public var alertBG:MovieClip;
      
      private var _perkLevelStr:String;
      
      private const ICON_WIDTH:Number = 40;
      
      private const ICON_HEIGHT:Number = 40;
      
      private var _originalPositionZ:Number;
      
      private const AnimTime = 8;
      
      private const AnimHighlightOffsetZ = 32;
      
      private const AnimSelectedOffsetZ = 0;
      
      public var SelectorArrow:MovieClip;
      
      public var iconColor:Color;
      
      public var hitbox:MovieClip;
      
      public const hitboxZ:int = 0;
      
      public var bShrinkText:Boolean = true;
      
      public function PerkSelectLineRenderer()
      {
         this.iconColor = new Color();
         super();
         preventAutosizing = true;
         this._originalPositionZ = z;
         addEventListener(FocusEvent.FOCUS_IN,this.handleFocusIn,false,0,true);
         disabledColor = 5393734;
         if(!enabled)
         {
            this.disableButton();
         }
         this.active = false;
         if(this.bShrinkText)
         {
            TextFieldEx.setTextAutoSize(textField,"shrink");
         }
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         if(param1)
         {
            visible = true;
            label = !!param1.Title?param1.Title:"";
            if(label == "")
            {
               visible = false;
            }
            if(this.perkLevelText != null)
            {
               this._perkLevelStr = !!param1.PerkLevel?param1.PerkLevel:"0";
               this.perkLevelText.text = this._perkLevelStr;
            }
            this.enabled = !!param1.unlocked?Boolean(param1.unlocked):true;
            this.bTierUnlocked = !!param1.bTierUnlocked?Boolean(param1.bTierUnlocked):false;
            this.glowActive = this.bTierUnlocked;
            if(param1.iconSource != null && param1.iconSource != "")
            {
               if(this.iconLoader != null)
               {
                  this.iconLoader.source = param1.iconSource;
               }
            }
         }
         else
         {
            visible = false;
         }
      }
      
      public function set glowActive(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.alertBG != null)
            {
               this.alertBG.gotoAndPlay("Glow");
            }
         }
         else if(this.alertBG != null)
         {
            this.alertBG.gotoAndStop("Off");
         }
      }
      
      public function get glowActive() : Boolean
      {
         if(this.alertBG)
         {
            return this.alertBG.currentFrameLabel == "Glow";
         }
         return false;
      }
      
      public function set stateOverride(param1:String) : void
      {
         setState(param1);
      }
      
      public function set active(param1:Boolean) : void
      {
         if(param1)
         {
            this.highlightButton();
         }
         if(!param1)
         {
            this.unhighlightButton();
         }
         if(this.SelectorArrow)
         {
            this.SelectorArrow.visible = param1;
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(this.perkLevelText && this._perkLevelStr)
         {
            this.perkLevelText.text = this._perkLevelStr;
         }
         if(this.bShrinkText)
         {
            TextFieldEx.setTextAutoSize(textField,"shrink");
         }
      }
      
      protected function handleFocusIn(param1:FocusEvent) : *
      {
         addEventListener(FocusEvent.FOCUS_OUT,this.handleFocusOut,false,0,true);
         removeEventListener(FocusEvent.FOCUS_IN,this.handleFocusIn);
         if(!selected)
         {
            this.highlightButton();
         }
      }
      
      protected function handleFocusOut(param1:FocusEvent) : *
      {
         addEventListener(FocusEvent.FOCUS_IN,this.handleFocusIn,false,0,true);
         removeEventListener(FocusEvent.FOCUS_OUT,this.handleFocusOut);
         if(!selected)
         {
            this.unhighlightButton();
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(!selected)
         {
            this.highlightButton();
         }
         setState("over");
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         if(!selected)
         {
            this.unhighlightButton();
         }
         setState("out");
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(param1)
         {
            this.highlightButton();
         }
         else
         {
            this.unhighlightButton();
         }
      }
      
      override protected function highlightButton() : *
      {
         if(enabled)
         {
            textField.textColor = highlightColor;
            if(this.perkLevelText)
            {
               this.perkLevelText.textColor = highlightColor;
            }
            this.hitbox.z = this.hitboxZ;
         }
         else
         {
            this.disableButton();
         }
      }
      
      override protected function unhighlightButton() : *
      {
         if(enabled)
         {
            textField.textColor = defaultColor;
            if(this.perkLevelText)
            {
               this.perkLevelText.textColor = defaultColor;
            }
            this.hitbox.z = 0;
         }
         else
         {
            this.disableButton();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(!super.enabled)
         {
            this.iconColor.setTint(disabledColor,1);
         }
         else
         {
            this.iconColor.setTint(highlightColor,1);
         }
         this.iconLoader.transform.colorTransform = this.iconColor;
         this.unhighlightButton();
      }
      
      protected function disableButton() : *
      {
         textField.textColor = disabledColor;
         if(this.perkLevelText)
         {
            this.perkLevelText.textColor = disabledColor;
         }
      }
   }
}
