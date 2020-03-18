package tripwire.controls
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import scaleform.clik.controls.UILoader;
   
   public class TripUILoaderQueue extends UILoader
   {
       
      
      private var _loaderQueue:Array;
      
      private var _numLoaders:Number;
      
      private var _curLoaderIndex:Number;
      
      private var _nextClearedQueueIndex:Number;
      
      public var bShowLogs:Boolean;
      
      public function TripUILoaderQueue()
      {
         super();
         this._loaderQueue = new Array();
         this._curLoaderIndex = this._numLoaders = 0;
         this._nextClearedQueueIndex = -1;
         this.bShowLogs = false;
      }
      
      public function clearQueue() : void
      {
         if(this._loaderQueue.length > 0)
         {
            this._loaderQueue.forEach(this.clearLoader);
            this._numLoaders = this._curLoaderIndex = this._nextClearedQueueIndex = 0;
            this.unload();
         }
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
            this.unload();
         }
         else
         {
            this.load(param1);
         }
      }
      
      override public function unload() : void
      {
         if(loader != null)
         {
            visible = _visiblilityBeforeLoad;
            removeChild(loader);
            loader = null;
         }
         _source = null;
         _loadOK = false;
         _sizeRetries = 0;
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
         this.unload();
         _source = param1;
         if(!_isLoading)
         {
            _visiblilityBeforeLoad = visible;
            visible = false;
         }
         var _loc2_:Number = this.findLoaderObj(_source);
         if(_loc2_ == -1)
         {
            if(loader == null)
            {
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.OPEN,handleLoadOpen,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.INIT,handleLoadInit,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleLoadComplete,false,0,true);
               loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,handleLoadProgress,false,0,true);
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleLoadIOError,false,0,true);
               this._loaderQueue.push({
                  "_loader":loader,
                  "sourceTag":_source,
                  "bLoaded":true
               });
               if(this.bShowLogs)
               {
                  trace("Bryan: " + this + " load :: loading index: " + this._loaderQueue.length + " with _source: " + _source + " total num loaders: " + this._numLoaders);
               }
            }
            addChild(loader);
            _isLoading = true;
            loader.load(new URLRequest(_source));
         }
         else
         {
            loader = this._loaderQueue[_loc2_]._loader;
            if(this.bShowLogs)
            {
               trace("Bryan: " + this + " load :: STILL Loaded index: " + _loc2_ + " with sourceTag: " + this._loaderQueue[_loc2_].sourceTag);
            }
            addChild(loader);
            _loadOK = true;
            _isLoading = false;
            invalidateSize();
            validateNow();
            this._curLoaderIndex = _loc2_;
         }
      }
      
      private function findLoaderObj(param1:String) : Number
      {
         var _loc2_:Number = 0;
         while(_loc2_ < this._loaderQueue.length)
         {
            if(this._loaderQueue[_loc2_].sourceTag == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function clearLoader(param1:*, param2:int, param3:Array) : *
      {
         if(param1.bLoaded)
         {
            if(this.bShowLogs)
            {
               trace("Bryan: " + this + " clearLoader :: Unloading image from index: " + param2 + " with source tag: " + param1.sourceTag);
            }
            param1._loader.unloadAndStop(true);
         }
         param1.bLoaded = false;
         param1.sourceTag = "";
      }
      
      private function reuseLoader() : Boolean
      {
         if(this._nextClearedQueueIndex == -1)
         {
            return false;
         }
         var _loc1_:Object = this._loaderQueue[this._nextClearedQueueIndex];
         if(_loc1_._loader != null)
         {
            this._numLoaders++;
            this._curLoaderIndex = this._nextClearedQueueIndex;
            _loc1_.sourceTag = _source;
            _loc1_.bLoaded = true;
            if(this.bShowLogs)
            {
               trace("Bryan: " + this + " reuseClearedLoader :: reusing _loaderQueueIndex: " + this._nextClearedQueueIndex + " with _source: " + _source + " total num loaders: " + this._numLoaders);
            }
            loader = _loc1_._loader;
            this.checkEventListeners();
            this._nextClearedQueueIndex = this._nextClearedQueueIndex + 1 < this._loaderQueue.length?Number(this._nextClearedQueueIndex + 1):Number(-1);
            if(this.bShowLogs)
            {
               trace("Bryan: " + this + " reuseLoader :: Ok so this is the _nextClearedQueueIndex: " + this._nextClearedQueueIndex);
            }
         }
         return true;
      }
      
      private function checkEventListeners() : void
      {
         if(!loader.contentLoaderInfo.hasEventListener(Event.OPEN))
         {
            loader.contentLoaderInfo.addEventListener(Event.OPEN,handleLoadOpen,false,0,true);
         }
         if(!loader.contentLoaderInfo.hasEventListener(Event.INIT))
         {
            loader.contentLoaderInfo.addEventListener(Event.INIT,handleLoadInit,false,0,true);
         }
         if(!loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
         {
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleLoadComplete,false,0,true);
         }
         if(!loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS))
         {
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,handleLoadProgress,false,0,true);
         }
         if(!loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleLoadIOError,false,0,true);
         }
      }
   }
}
