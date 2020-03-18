package
{
   import tripwire.containers.WeaponSelectGroupContainer;
   
   public dynamic class WeaponCategoryContainer extends WeaponSelectGroupContainer
   {
       
      
      public function WeaponCategoryContainer()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
