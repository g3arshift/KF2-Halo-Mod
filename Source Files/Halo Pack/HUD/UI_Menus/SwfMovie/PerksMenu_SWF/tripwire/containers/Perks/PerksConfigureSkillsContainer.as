package tripwire.containers.Perks
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.greensock.events.TweenEvent;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import scaleform.clik.controls.Button;
   
   public class PerksConfigureSkillsContainer extends PerkContainerBase
   {
       
      
      public var configureSkillsTitleTextfield:TextField;
      
      public var confirmButton:Button;
      
      public var tier0:PerkSkillButtonContainer;
      
      public var tier1:PerkSkillButtonContainer;
      
      public var tier2:PerkSkillButtonContainer;
      
      public var tier3:PerkSkillButtonContainer;
      
      public var tier4:PerkSkillButtonContainer;
      
      public var tierList:Vector.<PerkSkillButtonContainer>;
      
      private const NUM_TIERS:int = 5;
      
      private var tabIndexHelper:int = 0;
      
      public function PerksConfigureSkillsContainer()
      {
         this.tierList = new Vector.<PerkSkillButtonContainer>();
         super();
         visible = false;
         defaultFirstElement = this.tier0.skillButton0;
         ANIM_OFFSET_X = 0;
         defaultNumPrompts = 2;
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         this.initTierList();
      }
      
      private function initTierList() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.NUM_TIERS)
         {
            this.tierList.push(this["tier" + _loc1_]);
            _loc1_++;
         }
      }
      
      public function set skillList(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            this.tierList[_loc2_].setData(_loc3_);
            this.tierList[_loc2_].tier = _loc2_;
            this.tierList[_loc2_].skillButton0.tabIndex = ++this.tabIndexHelper;
            this.tierList[_loc2_].skillButton1.tabIndex = ++this.tabIndexHelper;
            _loc2_++;
         }
      }
      
      override protected function openAnimation(param1:Boolean = true) : *
      {
         TweenMax.killTweensOf(this);
         TweenMax.fromTo(this,ANIM_TIME,{
            "z":ANIM_OFFSET_Z,
            "x":ANIM_START_X + ANIM_OFFSET_X,
            "alpha":0,
            "ease":Linear.easeNone,
            "useFrames":true,
            "overwrite":1
         },{
            "z":ANIM_START_Z,
            "x":ANIM_START_X,
            "alpha":(!!param1?_defaultAlpha:_dimmedAlpha),
            "ease":Linear.easeNone,
            "useFrames":true,
            "onComplete":this.onOpened
         });
      }
      
      override public function selectContainer() : void
      {
         super.selectContainer();
         this.updateControllerIconVisibility();
      }
      
      override protected function onInputChange(param1:Event) : *
      {
         super.onInputChange(param1);
         this.updateControllerIconVisibility();
      }
      
      private function updateControllerIconVisibility() : void
      {
         this.confirmButton.visible = !bManagerUsingGamepad;
      }
      
      override protected function onOpened(param1:TweenEvent = null) : void
      {
         super.onOpened(param1);
         ExternalInterface.call("Callback_SkillSelectionOpened");
         dispatchEvent(new Event("SkillsConfiguredSeen"));
      }
      
      override public function set containerDisplayPrompts(param1:int) : void
      {
      }
   }
}
