package tripwire.containers.Perks
{
   import flash.text.TextField;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.controls.UILoader;
   import scaleform.clik.data.DataProvider;
   import tripwire.controls.TripUILoaderQueue;
   import tripwire.controls.perks.PerksPassiveDataLineRenderer;
   import tripwire.managers.MenuManager;
   
   public class PerkDetailsContainer extends PerkContainerBase
   {
       
      
      public var objectivesTitleTextField:TextField;
      
      public var objectiveTextField1:TextField;
      
      public var objectiveTextField2:TextField;
      
      public var perkBonusTextField:TextField;
      
      public var basicLoadoutTextField:TextField;
      
      public var weaponIconTextField0:TextField;
      
      public var weaponIconTextField1:TextField;
      
      public var weaponIconTextField2:TextField;
      
      public var weaponIconTextField3:TextField;
      
      public var weaponIcon0:TripUILoaderQueue;
      
      public var weaponIcon1:TripUILoaderQueue;
      
      public var weaponIcon2:TripUILoaderQueue;
      
      public var weaponIcon3:TripUILoaderQueue;
      
      public var passivesList:ScrollingList;
      
      private var _passiveObjects:Vector.<PerksPassiveDataLineRenderer>;
      
      public function PerkDetailsContainer()
      {
         super();
         ANIM_OFFSET_X = 0;
      }
      
      public function set passivesData(param1:Array) : *
      {
         if(param1 != null && this.passivesList != null)
         {
            this.passivesList.dataProvider = new DataProvider(param1);
         }
      }
      
      public function set detailsData(param1:Object) : *
      {
         if(param1 != null)
         {
            this.weaponIconTextField0.text = !!param1.WeaponName0?param1.WeaponName0:"";
            this.weaponIconTextField1.text = !!param1.WeaponName1?param1.WeaponName1:"";
            this.weaponIconTextField2.text = !!param1.WeaponName2?param1.WeaponName2:"";
            this.weaponIconTextField3.text = !!param1.WeaponName3?param1.WeaponName3:"";
            this.SetDataSource(param1.WeaponImage0,this.weaponIcon0);
            this.SetDataSource(param1.WeaponImage1,this.weaponIcon1);
            this.SetDataSource(param1.WeaponImage2,this.weaponIcon2);
            this.SetDataSource(param1.WeaponImage3,this.weaponIcon3);
            this.objectiveTextField1.text = !!param1.EXPAction1?param1.EXPAction1:"";
            this.objectiveTextField2.text = !!param1.EXPAction2?param1.EXPAction2:"";
         }
      }
      
      private function SetDataSource(param1:String, param2:UILoader) : *
      {
         if(param1 != null && param1 != "")
         {
            param2.source = param1;
            param2.visible = true;
         }
         else
         {
            param2.visible = false;
         }
      }
      
      override public function selectContainer() : void
      {
         defaultNumPrompts = !!MenuManager.manager.bOpenedInGame?5:4;
         super.selectContainer();
      }
   }
}
