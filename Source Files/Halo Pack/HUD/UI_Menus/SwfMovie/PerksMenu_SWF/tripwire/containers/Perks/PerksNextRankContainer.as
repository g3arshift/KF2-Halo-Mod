package tripwire.containers.Perks
{
   import flash.text.TextField;
   import scaleform.clik.controls.Button;
   import tripwire.managers.MenuManager;
   
   public class PerksNextRankContainer extends PerkContainerBase
   {
       
      
      public var prestigeButton:Button;
      
      public var rankTextField:TextField;
      
      public var titleTextField:TextField;
      
      public function PerksNextRankContainer()
      {
         super();
      }
      
      override public function selectContainer() : void
      {
         defaultNumPrompts = !!MenuManager.manager.bOpenedInGame?5:4;
         super.selectContainer();
      }
   }
}
