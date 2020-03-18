package tripwire.widgets
{
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;
   import tripwire.managers.HudManager;
   
   public class ControllerWeaponSelectWidget extends WeaponSelectWidget
   {
       
      
      public const controllerIconPrefix:String = "XboxTypeS_";
      
      public function ControllerWeaponSelectWidget()
      {
         super();
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         super.addedToStage(param1);
         throwIndicator.visible = true;
      }
      
      override public function open() : void
      {
         bIsControllerVersion = true;
         super.open();
      }
      
      public function set throwButton(param1:String) : void
      {
         if(param1.length > 15)
         {
            param1 = param1.substring(this.controllerIconPrefix.length);
         }
         throwIndicator.controllerTxt.text = param1;
         TextFieldEx.setImageSubstitutions(throwIndicator.controllerTxt,HudManager.manager.controllerIconObjects);
      }
      
      override public function showOnlyHUDGroup(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < weaponGroupContainers.length)
         {
            if(!weaponGroupContainers[_loc2_].visible && !weaponGroupContainers[_loc2_].bForceHidden)
            {
               weaponGroupContainers[_loc2_].visible = true;
            }
            if(param1 == _loc2_)
            {
               weaponGroupContainers[_loc2_].showAllElements();
            }
            else
            {
               weaponGroupContainers[_loc2_].showFirstElement();
            }
            _loc2_++;
         }
      }
      
      override public function showAllHUDGroups() : void
      {
      }
      
      override public function setSelectedIndex(param1:int, param2:int) : void
      {
         if(_currentGroupIndex != param1)
         {
            weaponGroupContainers[_currentGroupIndex].unselectGroup();
         }
         this.updateIndex(param1,param2);
      }
      
      override public function updateIndex(param1:int, param2:int) : *
      {
         super.updateIndex(param1,param2);
         if(weaponGroupContainers[param1] && weaponGroupContainers[param1].weaponList[param2] && throwIndicator)
         {
            throwIndicator.alpha = !!weaponGroupContainers[param1].weaponList[param2].throwable?1:0.5;
         }
      }
   }
}
