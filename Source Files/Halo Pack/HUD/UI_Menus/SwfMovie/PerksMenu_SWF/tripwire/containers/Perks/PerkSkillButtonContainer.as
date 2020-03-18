package tripwire.containers.Perks
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import flash.text.TextLineMetrics;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.Extensions;
   import tripwire.controls.TripDescriptionIconButton;
   
   public class PerkSkillButtonContainer extends UIComponent
   {
       
      
      public var skillButton0:TripDescriptionIconButton;
      
      public var skillButton1:TripDescriptionIconButton;
      
      private var _bUnlocked:Boolean = false;
      
      public var tierUnlockTextField:TextField;
      
      public var sectionText:TextField;
      
      public var leftDiv:MovieClip;
      
      public var rightDiv:MovieClip;
      
      public const CONTAINER_WIDTH:int = 960;
      
      public var _selectedSkill:int = 0;
      
      public var skillActiveSoundEffect:String = "PERK_CONFIGURE_SKILLS_CLICK";
      
      public function PerkSkillButtonContainer()
      {
         super();
      }
      
      public function set bUnlocked(param1:Boolean) : void
      {
         this._bUnlocked = param1;
         this.skillButton0.enabled = this.skillButton1.active = this._bUnlocked;
         this.skillButton1.enabled = this.skillButton1.active = this._bUnlocked;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.skillButton0.addEventListener(ButtonEvent.PRESS,this.onButtonPress,false,0,true);
         this.skillButton1.addEventListener(ButtonEvent.PRESS,this.onButtonPress,false,0,true);
      }
      
      private function onButtonPress(param1:ButtonEvent) : void
      {
         if(param1.currentTarget == this.skillButton0)
         {
            if(Extensions.gfxProcessSound != null && this.selectedSkill != 1)
            {
               Extensions.gfxProcessSound(this,"UI",this.skillActiveSoundEffect);
            }
            this.selectedSkill = 1;
            ExternalInterface.call("Callback_SkillSelected",this.skillButton0.tier,1);
         }
         else
         {
            if(Extensions.gfxProcessSound != null && this.selectedSkill != 2)
            {
               Extensions.gfxProcessSound(this,"UI",this.skillActiveSoundEffect);
            }
            this.selectedSkill = 2;
            ExternalInterface.call("Callback_SkillSelected",this.skillButton1.tier,2);
         }
      }
      
      public function set tier(param1:int) : void
      {
         this.skillButton0.tier = param1;
         this.skillButton1.tier = param1;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1)
         {
            visible = true;
            this.sectionText.text = !!param1.label?param1.label:"";
            this.bUnlocked = !!param1.bUnlocked?Boolean(param1.bUnlocked):false;
            this.tierUnlockTextField.text = !!param1.unlockLevel?param1.unlockLevel:"";
            if(param1.skill0 != null)
            {
               this.skillButton0.setData(param1.skill0);
            }
            if(param1.skill1 != null)
            {
               this.skillButton1.setData(param1.skill1);
            }
            this.selectedSkill = !!param1.selectedSkill?int(param1.selectedSkill):0;
            this.expandDivLines();
         }
         else
         {
            visible = false;
         }
      }
      
      public function get selectedSkill() : int
      {
         return this._selectedSkill;
      }
      
      public function set selectedSkill(param1:int) : void
      {
         this._selectedSkill = param1;
         switch(param1)
         {
            case 1:
               this.skillButton0.active = true;
               this.skillButton1.active = false;
               break;
            case 2:
               this.skillButton0.active = false;
               this.skillButton1.active = true;
               break;
            default:
               this.skillButton0.active = false;
               this.skillButton1.active = false;
         }
      }
      
      public function set sectionName(param1:String) : void
      {
         this.sectionText.text = param1;
      }
      
      public function expandDivLines() : void
      {
         var _loc1_:TextLineMetrics = this.sectionText.getLineMetrics(0);
         this.leftDiv.width = (this.CONTAINER_WIDTH - _loc1_.width - 32) / 2;
         this.rightDiv.width = this.leftDiv.width;
      }
      
      public function set levelUnlockText(param1:String) : void
      {
         this.tierUnlockTextField.text = param1;
      }
   }
}
