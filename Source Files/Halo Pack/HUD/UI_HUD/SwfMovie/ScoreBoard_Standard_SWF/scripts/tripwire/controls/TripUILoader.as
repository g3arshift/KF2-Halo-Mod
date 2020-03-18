package tripwire.controls
{
   import scaleform.clik.controls.UILoader;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class TripUILoader extends UILoader
   {
       
      
      public function TripUILoader()
      {
         super();
      }
      
      override public function set source(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(_source == param1)
         {
            return;
         }
         if((param1 == "" || param1 == null) && loader.content == null)
         {
            unload();
         }
         else
         {
            this.load(param1);
         }
      }
      
      override protected function load(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         unload();
         _source = param1;
         if(!_isLoading)
         {
            _visiblilityBeforeLoad = visible;
            visible = false;
         }
         if(loader == null)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.OPEN,handleLoadOpen,false,0,true);
            loader.contentLoaderInfo.addEventListener(Event.INIT,handleLoadInit,false,0,true);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleLoadComplete,false,0,true);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,handleLoadProgress,false,0,true);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleLoadIOError,false,0,true);
         }
         addChild(loader);
         _isLoading = true;
         loader.load(new URLRequest(_source));
      }
   }
}
