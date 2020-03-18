package tripwire.containers
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import com.greensock.TweenMax;
   import com.greensock.easing.Cubic;
   
   public class WeaponSelectItemContainer extends UIComponent
   {
       
      
      public var WeaponInfoContainer:MovieClip;
      
      public var EmptyContainer:MovieClip;
      
      public var WeaponItemRedBG:MovieClip;
      
      private var _data:Object;
      
      public var throwable:Boolean = false;
      
      public function WeaponSelectItemContainer()
      {
         super();
         this.WeaponInfoContainer.WeaponName.visible = false;
         this.WeaponItemRedBG.visible = false;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         this.throwable = !!param1.throwable?Boolean(param1.throwable):false;
         if(param1.texturePath != null && param1.texturePath != "")
         {
            this.WeaponInfoContainer.WeaponImageLoader.source = param1.texturePath;
            if(!this.WeaponInfoContainer.WeaponImageLoader.visible)
            {
               this.WeaponInfoContainer.WeaponImageLoader.visible = true;
            }
         }
         this.WeaponInfoContainer.WeaponName.text = param1.weaponName;
         this.updateCurrentAmmo(param1.ammoCount,param1.spareAmmoCount,param1.bUsesAmmo);
         this.updateSecondaryAmmo(param1.secondaryAmmoCount,param1.secondarySpareAmmoCount,param1.bUsesSecondaryAmmo,param1.bCanRefillSecondaryAmmo);
         this.enabled = !!param1.bEnabled?Boolean(param1.bEnabled):false;
      }
      
      public function updateCurrentAmmo(param1:int, param2:int, param3:Boolean) : *
      {
         if(param3)
         {
            this.ammoString = param1 + "/" + param2;
         }
         else
         {
            this.ammoString = "";
         }
      }
      
      public function updateSecondaryAmmo(param1:int, param2:int, param3:Boolean, param4:Boolean) : *
      {
         if(param3)
         {
            if(param4)
            {
               this.secondaryAmmoString = "〘 " + param1 + "/" + param2 + " 〙";
            }
            else
            {
               this.secondaryAmmoString = "〘 " + param1.toString() + " 〙";
            }
         }
         else
         {
            this.secondaryAmmoString = "";
         }
      }
      
      public function set ammoString(param1:String) : *
      {
         this.WeaponInfoContainer.WeaponAmmo.text = param1;
      }
      
      public function set secondaryAmmoString(param1:String) : *
      {
         this.WeaponInfoContainer.WeaponSecondaryAmmo.text = param1;
      }
      
      public function selected() : void
      {
         this.WeaponInfoContainer.WeaponName.visible = true;
         this.WeaponItemRedBG.visible = true;
         TweenMax.to(this,4,{
            "z":-64,
            "useFrames":true,
            "ease":Cubic.easeOut
         });
      }
      
      public function unselected() : void
      {
         this.WeaponInfoContainer.WeaponName.visible = false;
         this.WeaponItemRedBG.visible = false;
         TweenMax.to(this,4,{
            "z":0,
            "useFrames":true,
            "ease":Cubic.easeOut
         });
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.EmptyContainer.visible = false;
            this.alpha = 1;
         }
         else
         {
            this.EmptyContainer.visible = true;
            this.alpha = 0.5;
         }
      }
   }
}
