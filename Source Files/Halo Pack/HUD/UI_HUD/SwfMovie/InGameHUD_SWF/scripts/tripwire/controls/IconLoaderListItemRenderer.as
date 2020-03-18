package tripwire.controls
{
   import scaleform.clik.controls.UILoader;
   
   public class IconLoaderListItemRenderer extends TripListItemRenderer
   {
       
      
      public var iconLoader:UILoader;
      
      public function IconLoaderListItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.data = param1;
         if(data != null)
         {
            if(param1.iconPath != "")
            {
               visible = true;
               this.iconLoader.source = !!param1.iconPath?param1.iconPath:"";
            }
            else
            {
               visible = false;
            }
         }
         else
         {
            visible = false;
         }
      }
   }
}
