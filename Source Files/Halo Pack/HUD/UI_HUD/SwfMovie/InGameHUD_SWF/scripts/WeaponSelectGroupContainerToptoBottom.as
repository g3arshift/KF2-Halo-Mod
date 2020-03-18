package
{
   import tripwire.containers.WeaponSelectGroupContainer;
   
   public dynamic class WeaponSelectGroupContainerToptoBottom extends WeaponSelectGroupContainer
   {
       
      
      public function WeaponSelectGroupContainerToptoBottom()
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
