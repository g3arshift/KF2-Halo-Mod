package tripwire.Tools
{
   import scaleform.clik.layout.Layout;
   import flash.display.Sprite;
   import scaleform.clik.layout.LayoutData;
   import scaleform.clik.constants.LayoutMode;
   import flash.display.StageAlign;
   
   public class TripLayout extends Layout
   {
       
      
      public function TripLayout()
      {
         super();
      }
      
      override public function reflow() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:LayoutData = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:Sprite = null;
         var _loc10_:String = null;
         var _loc11_:Sprite = null;
         var _loc1_:uint = 0;
         while(_loc1_ < _managedSprites.length)
         {
            _loc2_ = _managedSprites[_loc1_];
            _loc3_ = _loc2_["layoutData"] as LayoutData;
            _loc4_ = _loc3_.alignH;
            _loc5_ = _loc3_.alignV;
            _loc6_ = _tiedToStageSize && _loc3_.offsetHashH[_aspectRatio] != undefined?Number(_loc3_.offsetHashH[_aspectRatio]):Number(_loc3_.offsetH);
            _loc7_ = _tiedToStageSize && _loc3_.offsetHashV[_aspectRatio] != undefined?Number(_loc3_.offsetHashV[_aspectRatio]):Number(_loc3_.offsetV);
            _loc8_ = _loc3_.relativeToH;
            _loc9_ = _loc8_ != null?_parent.getChildByName(_loc8_) as Sprite:null;
            _loc10_ = _loc3_.relativeToV;
            _loc11_ = _loc10_ != null?_parent.getChildByName(_loc10_) as Sprite:null;
            if(_loc11_ == null)
            {
               _loc11_ = _loc10_ != null?_parent.getChildByName("square" + _loc10_) as Sprite:null;
            }
            if(_loc4_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc4_ == LayoutMode.ALIGN_LEFT)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = rect.x + _loc6_;
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x - _loc2_.width + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_RIGHT)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = rect.width - _loc2_.width + _loc6_;
                     if(_tiedToStageSize && (stage.align == STAGE_ALIGN_CENTER || stage.align == StageAlign.TOP || stage.align == StageAlign.BOTTOM))
                     {
                        _loc2_.x = _loc2_.x + rect.x;
                     }
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x + _loc9_.width + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_CENTER)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = (rect.right + rect.left) / 2 - _loc2_.width / 2 + _loc6_;
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x + _loc9_.width / 2 - _loc2_.width / 2 + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_LEFT_BORDERS)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = rect.x + _loc6_;
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x + _loc6_;
                  }
               }
               else if(_loc4_ == LayoutMode.ALIGN_RIGHT_BORDERS)
               {
                  if(_loc9_ == null)
                  {
                     _loc2_.x = rect.x + _loc6_;
                  }
                  else
                  {
                     _loc2_.x = _loc9_.x + _loc9_.width - _loc2_.width + _loc6_;
                  }
               }
            }
            if(_loc5_ != LayoutMode.ALIGN_NONE)
            {
               if(_loc5_ == LayoutMode.ALIGN_TOP)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = rect.y + _loc7_;
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y - _loc2_.height + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_BOTTOM)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = rect.height - _loc2_.height + _loc7_;
                     if(_tiedToStageSize && (stage.align == STAGE_ALIGN_CENTER || stage.align == StageAlign.TOP || stage.align == StageAlign.BOTTOM))
                     {
                        _loc2_.y = _loc2_.y + rect.y;
                     }
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y + _loc11_.height + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_CENTER)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = (rect.bottom + rect.top) / 2 - _loc2_.height / 2 + _loc7_;
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y + _loc11_.height / 2 - _loc2_.height / 2 + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_TOP_BORDERS)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = rect.y + _loc7_;
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y + _loc7_;
                  }
               }
               else if(_loc5_ == LayoutMode.ALIGN_BOTTOM_BORDERS)
               {
                  if(_loc11_ == null)
                  {
                     _loc2_.y = rect.y + _loc7_;
                  }
                  else
                  {
                     _loc2_.y = _loc11_.y + _loc11_.height - _loc2_.height + _loc7_;
                  }
               }
            }
            _loc1_++;
         }
      }
   }
}
