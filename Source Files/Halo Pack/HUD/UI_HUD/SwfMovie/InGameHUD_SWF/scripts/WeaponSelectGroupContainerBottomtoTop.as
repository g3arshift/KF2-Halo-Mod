package
{
   import tripwire.containers.WeaponSelectGroupContainer;
   
   public dynamic class WeaponSelectGroupContainerBottomtoTop extends WeaponSelectGroupContainer
   {
       
      
      public function WeaponSelectGroupContainerBottomtoTop()
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
