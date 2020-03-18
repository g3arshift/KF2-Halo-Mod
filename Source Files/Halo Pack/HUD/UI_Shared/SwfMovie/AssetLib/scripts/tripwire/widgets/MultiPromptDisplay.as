package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   
   public class MultiPromptDisplay extends UIComponent
   {
       
      
      private var _displayedPrompts:Array;
      
      private var _prompts:Array;
      
      private var _basePrompt:ButtonPrompt;
      
      private var m_bBoundarySet:Boolean = false;
      
      private var _bUseWidthForBoundry;
      
      private var m_xMin:Number;
      
      private var m_xMax:Number;
      
      private var _promptSpacing:Number = 45;
      
      public var buttonPriority:Object;
      
      private var _bCenterAligned:Boolean;
      
      public var runningWidth:Number = 0;
      
      public function MultiPromptDisplay()
      {
         super();
         this._displayedPrompts = new Array();
         this._prompts = new Array();
         this.buttonPriority = new Object();
         this.buttonPriority["xboxtypes_a"] = this.buttonPriority["xboxtypes_a_o"] = 0;
         this.buttonPriority["xboxtypes_b"] = this.buttonPriority["xboxtypes_b_o"] = 1;
         this.buttonPriority["xboxtypes_x"] = this.buttonPriority["xboxtypes_x_o"] = 2;
         this.buttonPriority["xboxtypes_y"] = this.buttonPriority["xboxtypes_y_o"] = 3;
         this.buttonPriority["xboxtypes_start"] = this.buttonPriority["xboxtypes_start_o"] = 4;
         this.buttonPriority["xboxtypes_back"] = this.buttonPriority["xboxtypes_back_o"] = 5;
         this.buttonPriority["xboxtypes_leftshoulder"] = this.buttonPriority["xboxtypes_leftshoulder_o"] = 6;
         this.buttonPriority["xboxtypes_rightshoulder"] = this.buttonPriority["xboxtypes_rightshoulder_o"] = 7;
         this.buttonPriority["xboxtypes_lefttrigger"] = this.buttonPriority["xboxtypes_lefttrigger_o"] = 8;
         this.buttonPriority["xboxtypes_righttrigger"] = this.buttonPriority["xboxtypes_righttrigger_o"] = 9;
         this.buttonPriority["xboxtypes_dpad_up"] = this.buttonPriority["xboxtypes_dpad_up_o"] = 10;
         this.buttonPriority["xboxtypes_dpad_right"] = this.buttonPriority["xboxtypes_dpad_right_o"] = 11;
         this.buttonPriority["xboxtypes_dpad_down"] = this.buttonPriority["xboxtypes_dpad_down_o"] = 12;
         this.buttonPriority["xboxtypes_dpad_left"] = this.buttonPriority["xboxtypes_dpad_left_o"] = 13;
         this.buttonPriority["xboxtypes_leftthumbstick"] = this.buttonPriority["xboxtypes_leftthumbstick_o"] = 14;
         this.buttonPriority["xboxtypes_rightthumbstick"] = this.buttonPriority["xboxtypes_rightthumbstick_o"] = 15;
         if(this._basePrompt == null)
         {
            this._basePrompt = ButtonPrompt(getChildByName("_basePrompt"));
         }
         this.m_bBoundarySet = false;
         this._bCenterAligned = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._basePrompt.visible = false;
      }
      
      public function get bUseWidthForBoundry() : Boolean
      {
         return this._bUseWidthForBoundry;
      }
      
      public function set bUseWidthForBoundry(param1:Boolean) : void
      {
         if(!componentInspectorSetting || !param1)
         {
            return;
         }
         this.m_xMin = -(this.width / 2);
         this.m_xMax = this.m_xMin + this.width;
         this.m_bBoundarySet = true;
         setActualSize(this._basePrompt.width,actualHeight);
      }
      
      public function get promptSpacing() : Number
      {
         return this._promptSpacing;
      }
      
      public function set promptSpacing(param1:Number) : void
      {
         if(param1 == this._promptSpacing)
         {
            return;
         }
         this._promptSpacing = param1;
         if(!componentInspectorSetting)
         {
            this.updateDisplayedPrompts(false);
         }
      }
      
      public function get bCenterAligned() : Boolean
      {
         return this._bCenterAligned;
      }
      
      public function set bCenterAligned(param1:Boolean) : *
      {
         if(param1 == this._bCenterAligned)
         {
            return;
         }
         this._bCenterAligned = param1;
         if(!componentInspectorSetting)
         {
            this.updateDisplayedPrompts(false);
         }
      }
      
      public function get prompts() : Array
      {
         return this._prompts;
      }
      
      public function set prompts(param1:Array) : void
      {
         if(this._prompts == param1)
         {
            return;
         }
         this._prompts = param1;
         this.updateDisplayedPrompts(true);
      }
      
      public function setBoundary(param1:Number, param2:Number) : *
      {
         this.m_xMin = param1;
         this.m_xMax = param2;
         this.m_bBoundarySet = true;
         this.updateDisplayedPrompts(false);
      }
      
      public function setPromptAlpha(param1:String, param2:Number) : void
      {
         var _loc3_:Number = 0;
         while(_loc3_ < this._displayedPrompts.length)
         {
            if(this._displayedPrompts[_loc3_].buttonDisplay == param1)
            {
               this._displayedPrompts[_loc3_].alpha = param2;
            }
            _loc3_++;
         }
      }
      
      private function updateDisplayedPrompts(param1:Boolean) : *
      {
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:ButtonPrompt = null;
         var _loc8_:ButtonPrompt = null;
         var _loc9_:ButtonPrompt = null;
         if(param1)
         {
            if(this._prompts.length < this._displayedPrompts.length)
            {
               while(this._prompts.length < this._displayedPrompts.length)
               {
                  _loc7_ = ButtonPrompt(this._displayedPrompts.pop());
                  removeChild(_loc7_);
               }
            }
            else if(this._prompts.length > this._displayedPrompts.length)
            {
               while(this._displayedPrompts.length < this._prompts.length)
               {
                  _loc8_ = new ButtonPrompt();
                  addChild(_loc8_);
                  this._displayedPrompts.push(_loc8_);
               }
            }
            _loc5_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this._prompts.length)
            {
               _loc6_ = this._prompts[_loc5_].buttonDisplay.toLowerCase();
               this._prompts[_loc5_].priority = this.buttonPriority[_loc6_];
               _loc5_++;
            }
            this._prompts.sortOn("priority",Array.NUMERIC);
         }
         this.runningWidth = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < this._displayedPrompts.length)
         {
            _loc9_ = ButtonPrompt(this._displayedPrompts[_loc4_]);
            if(this._prompts[_loc4_].promptData != null)
            {
               _loc9_.promptData = this._prompts[_loc4_].promptData;
            }
            else
            {
               _loc9_.promptText = this._prompts[_loc4_].promptText;
               _loc9_.buttonDisplay = this._prompts[_loc4_].buttonDisplay;
            }
            _loc9_.visible = true;
            if(_loc4_ > 0)
            {
               _loc9_.x = this._displayedPrompts[_loc4_ - 1].x + this._displayedPrompts[_loc4_ - 1].width + this._promptSpacing;
               this.runningWidth = this.runningWidth + (this._displayedPrompts[_loc4_ - 1].width + this._promptSpacing);
               if(this.m_bBoundarySet)
               {
                  if(this.runningWidth > this.m_xMax * 2)
                  {
                     if(this.bCenterAligned)
                     {
                        this.centerPrompts(_loc3_,_loc4_,this.runningWidth - (this._displayedPrompts[_loc4_ - 1].width + this._promptSpacing));
                     }
                     _loc2_ = _loc2_ + this._basePrompt.height;
                     _loc9_.x = 0;
                     this.runningWidth = 0;
                     _loc3_ = _loc4_;
                  }
               }
               _loc9_.y = _loc2_;
            }
            else
            {
               _loc9_.x = 0;
            }
            _loc4_++;
         }
         this.runningWidth = this.runningWidth + this._displayedPrompts[this._displayedPrompts.length - 1].width;
         if(this.bCenterAligned)
         {
            this.centerPrompts(_loc3_,this._displayedPrompts.length,this.runningWidth);
         }
      }
      
      private function centerPrompts(param1:Number, param2:Number, param3:Number) : *
      {
         var _loc4_:Number = param1;
         while(_loc4_ < param2)
         {
            this._displayedPrompts[_loc4_].x = this._displayedPrompts[_loc4_].x - param3 / 2;
            _loc4_++;
         }
      }
   }
}
