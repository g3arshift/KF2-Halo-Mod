package tripwire.controls
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class TripDescriptionIconButton extends TripButton
   {
       
      
      public var descriptionTextfield:TextField;
      
      public var iconLoader:TripUILoaderQueue;
      
      public var activeIndicator:MovieClip;
      
      public var bumpers:MovieClip;
      
      public var enabledBG:MovieClip;
      
      public var tier:int = 0;
      
      public var iconColor:Color;
      
      public var titleColor:uint = 14538703;
      
      public var baseColor:uint = 14538703;
      
      public var highlightColor:uint = 14538703;
      
      public var disabledColor:uint = 8814195;
      
      public function TripDescriptionIconButton()
      {
         this.iconColor = new Color();
         super();
         preventAutosizing = true;
         overSoundEffect = "PERK_CONFIGURE_SKILLS_ITEM_ROLLOVER";
         this.bumpers.visible = false;
         TextFieldEx.setVerticalAlign(this.descriptionTextfield,TextFieldEx.VALIGN_CENTER);
      }
      
      public function setData(param1:Object) : void
      {
         this.unhighlightButton();
         this.icon = !!param1.iconSource?param1.iconSource:"";
         this.TitleText = !!param1.label?param1.label:"";
         this.DescriptionText = !!param1.description?param1.description:"";
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.active = false;
      }
      
      public function set icon(param1:String) : void
      {
         if(param1 != null && param1 != "")
         {
            this.iconLoader.source = param1;
         }
      }
      
      public function set TitleText(param1:String) : void
      {
         label = param1;
      }
      
      public function set DescriptionText(param1:String) : void
      {
         this.descriptionTextfield.text = param1;
      }
      
      public function set active(param1:*) : void
      {
         this.activeIndicator.visible = param1;
         this.bumpers.visible = param1;
         this.unhighlightButton();
      }
      
      override protected function highlightButton() : *
      {
         if(enabled)
         {
            this.iconColor.setTint(this.highlightColor,1);
            this.iconLoader.transform.colorTransform = this.iconColor;
            textField.textColor = this.highlightColor;
            this.descriptionTextfield.textColor = this.highlightColor;
         }
      }
      
      override protected function unhighlightButton() : *
      {
         if(enabled)
         {
            if(!this.activeIndicator.visible)
            {
               this.iconColor.setTint(this.titleColor,1);
               this.iconLoader.transform.colorTransform = this.iconColor;
               textField.textColor = this.titleColor;
               this.descriptionTextfield.textColor = this.baseColor;
            }
            else
            {
               this.highlightButton();
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.bumpers.visible = param1;
         this.enabledBG.visible = !param1;
         if(!param1)
         {
            this.iconColor.setTint(this.disabledColor,1);
            this.iconLoader.transform.colorTransform = this.iconColor;
         }
      }
   }
}
