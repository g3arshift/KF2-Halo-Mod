package tripwire.containers.Perks
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import tripwire.containers.TripContainer;
   import tripwire.managers.MenuManager;
   
   public class PerkContainerBase extends TripContainer
   {
       
      
      public var bOpenInConfig:Boolean = false;
      
      public function PerkContainerBase()
      {
         super();
      }
      
      override public function set containerDisplayPrompts(param1:int) : void
      {
      }
      
      override public function openContainer(param1:Boolean = true) : void
      {
         if(!_bOpen)
         {
            if(!initialized)
            {
               this.bOpenInConfig = true;
               return;
            }
            if(currentElement == null && bManagerUsingGamepad && defaultFirstElement)
            {
               currentElement = defaultFirstElement;
            }
            if(stage)
            {
               stage.addEventListener(MenuManager.INPUT_CHANGED,onInputChange,false,0,true);
            }
            selectContainer();
            if(isNaN(ANIM_START_X))
            {
               this.alpha = 0;
               TweenMax.to(this,1,{
                  "useFrames":true,
                  "onComplete":this.openAnimation,
                  "onCompleteParams":[param1]
               });
            }
            else
            {
               this.alpha = 0;
               this.openAnimation(param1);
            }
            _bOpen = true;
         }
      }
      
      override protected function configUI() : void
      {
         if(this.bOpenInConfig)
         {
            this.openContainer();
            this.bOpenInConfig = false;
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
            "onComplete":onOpened
         });
      }
   }
}
