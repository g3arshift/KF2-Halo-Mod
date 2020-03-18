package tripwire.containers
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import com.greensock.TweenMax;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   import com.greensock.easing.Linear;
   
   public class WeaponSelectGroupContainer extends UIComponent
   {
       
      
      public var WeaponCategoryHeaderContainer:MovieClip;
      
      private const MAX_WEAPONS:int = 3;
      
      private var _weaponItemContainers:Vector.<tripwire.containers.WeaponSelectItemContainer>;
      
      private var _weaponList:Array;
      
      private var _selectedIndex:int = 0;
      
      private var _selectedItem:tripwire.containers.WeaponSelectItemContainer;
      
      private var _firstItemIndex:int;
      
      private var _headerName:String = "";
      
      public var UpArrow:MovieClip;
      
      public var DownArrow:MovieClip;
      
      public var bControllerParent:Boolean;
      
      public var bForceHidden:Boolean;
      
      public var fadedAlpha:Number = 0.5;
      
      public var widgetLocation:String = "LEFT";
      
      private const EWL_LEFT:int = 0;
      
      private const EWL_RIGHT:int = 1;
      
      private const EWL_TOP:int = 2;
      
      private const EWL_BOTTOM:int = 3;
      
      private var myTween:TweenMax;
      
      private var myTween2:TweenMax;
      
      private var weaponContainer0_BaseX:Number;
      
      private var weaponContainer1_BaseX:Number;
      
      private var weaponContainer2_BaseX:Number;
      
      private var weaponContainer0_BaseY:Number;
      
      private var weaponContainer1_BaseY:Number;
      
      private var weaponContainer2_BaseY:Number;
      
      private var weaponContainer0_BaseAlpha:Number;
      
      private var weaponContainer1_BaseAlpha:Number;
      
      private var weaponContainer2_BaseAlpha:Number;
      
      private var weaponContainer0_BaseScale:Number;
      
      private var weaponContainer1_BaseScale:Number;
      
      private var weaponContainer2_BaseScale:Number;
      
      public function WeaponSelectGroupContainer()
      {
         super();
         this.updateContainers();
         this.alpha = this.fadedAlpha;
      }
      
      public function get weaponList() : Array
      {
         return this._weaponList;
      }
      
      public function set weaponList(param1:Array) : void
      {
         this._weaponList = param1;
         this.updateWeaponList();
         this.updateArrows();
      }
      
      public function get header() : String
      {
         return this._headerName;
      }
      
      public function set header(param1:String) : void
      {
         var _loc2_:TextField = this.WeaponCategoryHeaderContainer.CategoryTextContainer.CategoryText;
         this._headerName = param1;
         _loc2_.htmlText = param1;
         if(this.bControllerParent)
         {
            TextFieldEx.setVerticalAlign(_loc2_,TextFieldEx.VALIGN_CENTER);
         }
      }
      
      public function updateContainers() : *
      {
         this._selectedItem = null;
         this._weaponItemContainers = new Vector.<tripwire.containers.WeaponSelectItemContainer>();
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_WEAPONS)
         {
            this._weaponItemContainers.push(this["WeaponItem" + _loc1_]);
            _loc1_++;
         }
         this.weaponContainer0_BaseX = this._weaponItemContainers[0].x;
         this.weaponContainer1_BaseX = this._weaponItemContainers[1].x;
         this.weaponContainer2_BaseX = this._weaponItemContainers[2].x;
         this.weaponContainer0_BaseY = this._weaponItemContainers[0].y;
         this.weaponContainer1_BaseY = this._weaponItemContainers[1].y;
         this.weaponContainer2_BaseY = this._weaponItemContainers[2].y;
         this.weaponContainer0_BaseAlpha = this._weaponItemContainers[0].alpha;
         this.weaponContainer1_BaseAlpha = this._weaponItemContainers[1].alpha;
         this.weaponContainer2_BaseAlpha = this._weaponItemContainers[2].alpha;
         this.weaponContainer0_BaseScale = this._weaponItemContainers[0].scaleX;
         this.weaponContainer1_BaseScale = this._weaponItemContainers[1].scaleX;
         this.weaponContainer2_BaseScale = this._weaponItemContainers[2].scaleX;
      }
      
      public function showAllElements() : *
      {
         this.updateWeaponList();
      }
      
      public function showFirstElement() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_WEAPONS)
         {
            if(_loc2_ < this.weaponList.length)
            {
               _loc1_ = this.firstItemIndex + _loc2_;
               if(_loc1_ > this.weaponList.length - 1)
               {
                  _loc1_ = _loc1_ % this.weaponList.length;
               }
               this._weaponItemContainers[_loc2_].data = this.weaponList[_loc1_];
               if(_loc2_ == 0)
               {
                  this._weaponItemContainers[_loc2_].visible = true;
               }
               else
               {
                  this._weaponItemContainers[_loc2_].visible = true;
               }
            }
            else
            {
               this._weaponItemContainers[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function updateWeaponList() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_WEAPONS)
         {
            if(this.weaponList.length == 0)
            {
               this.visible = false;
               this.bForceHidden = true;
               this._weaponItemContainers[_loc2_].visible = false;
            }
            else if(_loc2_ < this.weaponList.length)
            {
               if(!this.visible)
               {
                  this.visible = true;
               }
               if(!this._weaponItemContainers[_loc2_].visible)
               {
                  this._weaponItemContainers[_loc2_].visible = true;
               }
               _loc1_ = this.firstItemIndex + _loc2_;
               if(_loc1_ > this.weaponList.length - 1)
               {
                  _loc1_ = _loc1_ % this.weaponList.length;
               }
               this._weaponItemContainers[_loc2_].data = this.weaponList[_loc1_];
            }
            else
            {
               this._weaponItemContainers[_loc2_].visible = false;
            }
            _loc2_++;
         }
         this.updateArrows();
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc2_:int = this._selectedIndex;
         this._selectedIndex = param1;
         if(this.bControllerParent)
         {
            this.firstItemIndex = this.selectedIndex;
            this._selectedItem = this._weaponItemContainers[0];
         }
         else
         {
            if(param1 == 0)
            {
               this.firstItemIndex = 0;
            }
            else if(param1 < _loc2_)
            {
               if(param1 >= this.MAX_WEAPONS && _loc2_ + this.MAX_WEAPONS <= param1)
               {
                  this.firstItemIndex = param1 + 1;
               }
               else if(this.firstItemIndex != 0 && this.firstItemIndex == _loc2_)
               {
                  this.firstItemIndex = param1;
               }
            }
            else if(param1 > _loc2_ && param1 >= this.firstItemIndex + this.MAX_WEAPONS)
            {
               this.firstItemIndex = param1 - (this.MAX_WEAPONS - 1);
            }
            if(this._selectedItem != null)
            {
               this._selectedItem.unselected();
            }
            this._selectedItem = this._weaponItemContainers[param1 - this.firstItemIndex];
         }
         this._selectedItem.selected();
         if(this.bControllerParent && _loc2_ != this._selectedIndex)
         {
            this.playSelectAnim();
         }
      }
      
      public function get firstItemIndex() : int
      {
         return this._firstItemIndex;
      }
      
      public function set firstItemIndex(param1:*) : void
      {
         if(this._firstItemIndex != param1)
         {
            this._firstItemIndex = param1;
            this.updateWeaponList();
         }
      }
      
      public function unselectGroup() : void
      {
         if(this._selectedItem != null)
         {
            if(this.bControllerParent)
            {
               this._weaponItemContainers[0].unselected();
               this._selectedItem = null;
            }
            else
            {
               this.selectedIndex = 0;
               this._selectedItem.unselected();
               this._selectedItem = null;
            }
            if(this.visible && this.bControllerParent)
            {
               this.alpha = this.fadedAlpha;
            }
         }
      }
      
      private function updateArrows() : void
      {
         if(this.bControllerParent)
         {
            this.DownArrow.visible = this.weaponList.length > this.MAX_WEAPONS;
            this.UpArrow.visible = false;
         }
         else
         {
            if(this.firstItemIndex > 0)
            {
               this.UpArrow.visible = true;
            }
            else
            {
               this.UpArrow.visible = false;
            }
            if(this.weaponList.length > this.MAX_WEAPONS)
            {
               this.DownArrow.visible = true;
               if(this.selectedIndex == this.weaponList.length - 1)
               {
                  this.DownArrow.visible = false;
               }
            }
            else
            {
               this.DownArrow.visible = false;
            }
         }
      }
      
      private function initArrows() : void
      {
         if(this.weaponList.length > this.MAX_WEAPONS)
         {
            this.DownArrow.visible = true;
         }
         else
         {
            this.DownArrow.visible = false;
         }
         this.UpArrow.visible = false;
      }
      
      private function playSelectAnim() : *
      {
         switch(this.widgetLocation)
         {
            case "LEFT":
               TweenMax.killTweensOf(this._weaponItemContainers[0]);
               TweenMax.killTweensOf(this._weaponItemContainers[1]);
               TweenMax.killTweensOf(this._weaponItemContainers[2]);
               TweenMax.fromTo(this._weaponItemContainers[1],6,{
                  "x":this.weaponContainer1_BaseX,
                  "alpha":this.weaponContainer1_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this.weaponContainer1_BaseX + this._weaponItemContainers[0].width,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[1],this.weaponContainer1_BaseX,this.weaponContainer1_BaseY,this.weaponContainer1_BaseAlpha,this.weaponContainer1_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[2],6,{
                  "x":this.weaponContainer2_BaseX,
                  "alpha":this.weaponContainer2_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this.weaponContainer2_BaseX + this._weaponItemContainers[0].width,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[2],this.weaponContainer2_BaseX,this.weaponContainer2_BaseY,this.weaponContainer2_BaseAlpha,this.weaponContainer2_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[0],8,{
                  "scaleX":1,
                  "scaleY":1,
                  "alpha":1,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this._weaponItemContainers[0],
                  "scaleX":1.15,
                  "scaleY":1.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":function():*
                  {
                     _weaponItemContainers[0].scaleX = 1;
                     _weaponItemContainers[0].scaleY = 1;
                  }
               });
               break;
            case "RIGHT":
               TweenMax.fromTo(this._weaponItemContainers[1],6,{
                  "x":this.weaponContainer1_BaseX,
                  "alpha":this.weaponContainer1_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this.weaponContainer1_BaseX - this._weaponItemContainers[0].width,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[1],this.weaponContainer1_BaseX,this.weaponContainer1_BaseY,this.weaponContainer1_BaseAlpha,this.weaponContainer1_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[2],6,{
                  "x":this.weaponContainer2_BaseX,
                  "alpha":this.weaponContainer2_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this.weaponContainer2_BaseX - this._weaponItemContainers[0].width,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[2],this.weaponContainer2_BaseX,this.weaponContainer2_BaseY,this.weaponContainer2_BaseAlpha,this.weaponContainer2_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[0],8,{
                  "scaleX":1,
                  "scaleY":1,
                  "alpha":1,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this._weaponItemContainers[0],
                  "scaleX":1.15,
                  "scaleY":1.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":function():*
                  {
                     _weaponItemContainers[0].scaleX = 1;
                     _weaponItemContainers[0].scaleY = 1;
                  }
               });
               break;
            case "UP":
               TweenMax.fromTo(this._weaponItemContainers[1],6,{
                  "y":this.weaponContainer1_BaseY,
                  "alpha":this.weaponContainer1_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "y":this.weaponContainer1_BaseY + this._weaponItemContainers[0].height,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[1],this.weaponContainer1_BaseX,this.weaponContainer1_BaseY,this.weaponContainer1_BaseAlpha,this.weaponContainer1_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[2],6,{
                  "y":this.weaponContainer2_BaseY,
                  "alpha":this.weaponContainer2_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "y":this.weaponContainer2_BaseY + this._weaponItemContainers[0].height,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[2],this.weaponContainer2_BaseX,this.weaponContainer2_BaseY,this.weaponContainer2_BaseAlpha,this.weaponContainer2_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[0],8,{
                  "scaleX":1,
                  "scaleY":1,
                  "alpha":1,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this._weaponItemContainers[0],
                  "scaleX":1.15,
                  "scaleY":1.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":function():*
                  {
                     _weaponItemContainers[0].scaleX = 1;
                     _weaponItemContainers[0].scaleY = 1;
                  }
               });
               break;
            case "DOWN":
               TweenMax.fromTo(this._weaponItemContainers[1],6,{
                  "y":this.weaponContainer1_BaseY,
                  "alpha":this.weaponContainer1_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "y":this.weaponContainer1_BaseY - this._weaponItemContainers[0].height,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[1],this.weaponContainer1_BaseX,this.weaponContainer1_BaseY,this.weaponContainer1_BaseAlpha,this.weaponContainer1_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[2],6,{
                  "y":this.weaponContainer2_BaseY,
                  "alpha":this.weaponContainer2_BaseAlpha,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "y":this.weaponContainer2_BaseY - this._weaponItemContainers[0].height,
                  "alpha":0.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":this.resetWidgets,
                  "onCompleteParams":[this._weaponItemContainers[2],this.weaponContainer2_BaseX,this.weaponContainer2_BaseY,this.weaponContainer2_BaseAlpha,this.weaponContainer2_BaseScale]
               });
               TweenMax.fromTo(this._weaponItemContainers[0],8,{
                  "scaleX":1,
                  "scaleY":1,
                  "alpha":1,
                  "ease":Linear.easeNone,
                  "useFrames":true
               },{
                  "x":this._weaponItemContainers[0],
                  "scaleX":1.15,
                  "scaleY":1.15,
                  "ease":Linear.easeNone,
                  "useFrames":true,
                  "onComplete":function():*
                  {
                     _weaponItemContainers[0].scaleX = 1;
                     _weaponItemContainers[0].scaleY = 1;
                  }
               });
         }
      }
      
      private function resetWidgets(param1:Object, param2:Number, param3:Number, param4:Number, param5:Number) : *
      {
         TweenMax.to(param1,4,{
            "x":param2,
            "y":param3,
            "alpha":param4,
            "scaleX":param5,
            "scaleY":param5,
            "ease":Linear.easeNone,
            "useFrames":true
         });
      }
   }
}
