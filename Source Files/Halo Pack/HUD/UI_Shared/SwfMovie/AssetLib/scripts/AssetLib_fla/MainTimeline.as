package AssetLib_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.clik.controls.ButtonBar;
   import tripwire.widgets.VoipNotificationWidget;
   import scaleform.clik.data.DataProvider;
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var ChatBoxWidget:PlayerChatWidget;
      
      public var NewDropDownList:$DropDownScrollingList;
      
      public var NewScrollingList:TripScrollingList;
      
      public var PerkIcons:PerkIconClass;
      
      public var ServerBrowserHeader:HeaderMC;
      
      public var Text137:TextField;
      
      public var __id3_:DefaultLabel;
      
      public var __id4_:$Slider;
      
      public var backButton:$BaseButton;
      
      public var buttonBar:ButtonBar;
      
      public var categoryButton:CategoryButtonMC;
      
      public var dropdown:DefaultDropdownMenu;
      
      public var dropdown2:DefaultDropdownMenu;
      
      public var optionStepper:DefaultOptionStepper;
      
      public var scrollBar:DefaultScrollBar;
      
      public var searchBar:$TripSearchBar;
      
      public var subCategoryButton:SubCategoryButtonMC;
      
      public var subHeader:$SubHeaderMC;
      
      public var textContainer:$TripTextArea;
      
      public var titleButton:TitleButtonMC;
      
      public var voipList:VoipNotificationWidget;
      
      public var voipVolumeSlider:SliderOption;
      
      public var i:int;
      
      public var itemsData:Array;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1);
         this.__setProp_categoryButton_Scene1_Layer1_0();
         this.__setProp_titleButton_Scene1_Layer1_0();
         this.__setProp_NewScrollingList_Scene1_Layer1_0();
         this.__setProp_backButton_Scene1_Layer1_0();
         this.__setProp_textContainer_Scene1_Layer1_0();
         this.__setProp_voipList_Scene1_Layer1_0();
         this.__setProp___id3__Scene1_Layer1_0();
         this.__setProp_searchBar_Scene1_Layer1_0();
         this.__setProp___id4__Scene1_Layer1_0();
         this.__setProp_dropdown2_Scene1_Layer1_0();
         this.__setProp_NewDropDownList_Scene1_Layer1_0();
         this.__setProp_dropdown_Scene1_Layer1_0();
         this.__setProp_buttonBar_Scene1_ButtonBar_0();
      }
      
      function __setProp_categoryButton_Scene1_Layer1_0() : *
      {
         try
         {
            this.categoryButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.categoryButton.autoRepeat = false;
         this.categoryButton.autoSize = "none";
         this.categoryButton.data = "";
         this.categoryButton.enabled = true;
         this.categoryButton.enableInitCallback = false;
         this.categoryButton.focusable = true;
         this.categoryButton.infoString = "INFO";
         this.categoryButton.label = "TITLE";
         this.categoryButton.selected = false;
         this.categoryButton.toggle = false;
         this.categoryButton.visible = true;
         try
         {
            this.categoryButton["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_titleButton_Scene1_Layer1_0() : *
      {
         try
         {
            this.titleButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.titleButton.autoRepeat = false;
         this.titleButton.autoSize = "none";
         this.titleButton.data = "";
         this.titleButton.enabled = true;
         this.titleButton.enableInitCallback = false;
         this.titleButton.focusable = true;
         this.titleButton.label = "Please Create This Game";
         this.titleButton.selected = false;
         this.titleButton.toggle = true;
         this.titleButton.visible = true;
         try
         {
            this.titleButton["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_NewScrollingList_Scene1_Layer1_0() : *
      {
         try
         {
            this.NewScrollingList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.NewScrollingList.enabled = true;
         this.NewScrollingList.enableInitCallback = false;
         this.NewScrollingList.focusable = true;
         this.NewScrollingList.itemRendererName = "DefaultTripListItemRenderer";
         this.NewScrollingList.itemRendererInstanceName = "";
         this.NewScrollingList.margin = 0;
         this.NewScrollingList.inspectablePadding = {
            "top":2.5,
            "right":8,
            "bottom":8,
            "left":-1.5
         };
         this.NewScrollingList.rowHeight = 0;
         this.NewScrollingList.scrollBar = "";
         this.NewScrollingList.visible = true;
         this.NewScrollingList.wrapping = "normal";
         try
         {
            this.NewScrollingList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_backButton_Scene1_Layer1_0() : *
      {
         try
         {
            this.backButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.backButton.autoRepeat = false;
         this.backButton.autoSize = "left";
         this.backButton.data = "";
         this.backButton.enabled = true;
         this.backButton.enableInitCallback = false;
         this.backButton.focusable = true;
         this.backButton.label = "<<BACK NOW";
         this.backButton.selected = false;
         this.backButton.toggle = false;
         this.backButton.visible = true;
         try
         {
            this.backButton["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_textContainer_Scene1_Layer1_0() : *
      {
         try
         {
            this.textContainer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.textContainer.actAsButton = false;
         this.textContainer.defaultText = "";
         this.textContainer.displayAsPassword = false;
         this.textContainer.editable = false;
         this.textContainer.enabled = true;
         this.textContainer.enableInitCallback = false;
         this.textContainer.focusable = true;
         this.textContainer.maxChars = 0;
         this.textContainer.minThumbSize = 2;
         this.textContainer.scrollBar = "";
         this.textContainer.text = "I am your body.";
         this.textContainer.thumbOffset = {
            "top":0,
            "bottom":0
         };
         this.textContainer.titleText = "I am your title";
         this.textContainer.visible = true;
         try
         {
            this.textContainer["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_voipList_Scene1_Layer1_0() : *
      {
         try
         {
            this.voipList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.voipList.enabled = true;
         this.voipList.enableInitCallback = true;
         this.voipList.visible = true;
         try
         {
            this.voipList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp___id3__Scene1_Layer1_0() : *
      {
         try
         {
            this.__id3_["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.__id3_.autoSize = "none";
         this.__id3_.enabled = true;
         this.__id3_.enableInitCallback = false;
         this.__id3_.text = "label";
         this.__id3_.visible = true;
         try
         {
            this.__id3_["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_searchBar_Scene1_Layer1_0() : *
      {
         try
         {
            this.searchBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.searchBar.actAsButton = true;
         this.searchBar.defaultText = "";
         this.searchBar.displayAsPassword = false;
         this.searchBar.editable = true;
         this.searchBar.enabled = true;
         this.searchBar.enableInitCallback = false;
         this.searchBar.focusable = true;
         this.searchBar.maxChars = 128;
         this.searchBar.text = "Search";
         this.searchBar.visible = true;
         try
         {
            this.searchBar["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp___id4__Scene1_Layer1_0() : *
      {
         try
         {
            this.__id4_["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.__id4_.enabled = true;
         this.__id4_.enableInitCallback = false;
         this.__id4_.focusable = false;
         this.__id4_.liveDragging = true;
         this.__id4_.maximum = 10;
         this.__id4_.minimum = 0;
         this.__id4_.offsetLeft = 0;
         this.__id4_.offsetRight = 0;
         this.__id4_.snapInterval = 1;
         this.__id4_.snapping = false;
         this.__id4_.value = 0;
         this.__id4_.visible = true;
         try
         {
            this.__id4_["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_dropdown2_Scene1_Layer1_0() : *
      {
         try
         {
            this.dropdown2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.dropdown2.autoSize = "none";
         this.dropdown2.dropdown = "$DropDownScrollingList";
         this.dropdown2.enabled = false;
         this.dropdown2.enableInitCallback = false;
         this.dropdown2.focusable = true;
         this.dropdown2.itemRenderer = "DefaultTripListItemRenderer";
         this.dropdown2.menuDirection = "down";
         this.dropdown2.menuMargin = 1;
         this.dropdown2.inspectableMenuOffset = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         this.dropdown2.inspectableMenuPadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         this.dropdown2.menuRowCount = 0;
         this.dropdown2.menuWidth = -1;
         this.dropdown2.menuWrapping = "normal";
         this.dropdown2.scrollBar = "";
         this.dropdown2.inspectableThumbOffset = {
            "top":0,
            "bottom":0
         };
         this.dropdown2.visible = true;
         try
         {
            this.dropdown2["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_NewDropDownList_Scene1_Layer1_0() : *
      {
         try
         {
            this.NewDropDownList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.NewDropDownList.enabled = true;
         this.NewDropDownList.enableInitCallback = false;
         this.NewDropDownList.focusable = true;
         this.NewDropDownList.itemRendererName = "DefaultTripListItemRenderer";
         this.NewDropDownList.itemRendererInstanceName = "";
         this.NewDropDownList.margin = 0;
         this.NewDropDownList.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         this.NewDropDownList.rowHeight = 0;
         this.NewDropDownList.scrollBar = "";
         this.NewDropDownList.visible = true;
         this.NewDropDownList.wrapping = "normal";
         try
         {
            this.NewDropDownList["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_dropdown_Scene1_Layer1_0() : *
      {
         try
         {
            this.dropdown["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.dropdown.autoSize = "none";
         this.dropdown.dropdown = "$DropDownScrollingList";
         this.dropdown.enabled = true;
         this.dropdown.enableInitCallback = false;
         this.dropdown.focusable = true;
         this.dropdown.itemRenderer = "DefaultTripListItemRenderer";
         this.dropdown.menuDirection = "down";
         this.dropdown.menuMargin = 1;
         this.dropdown.inspectableMenuOffset = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         this.dropdown.inspectableMenuPadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         this.dropdown.menuRowCount = 0;
         this.dropdown.menuWidth = -1;
         this.dropdown.menuWrapping = "normal";
         this.dropdown.scrollBar = "";
         this.dropdown.inspectableThumbOffset = {
            "top":0,
            "bottom":0
         };
         this.dropdown.visible = true;
         try
         {
            this.dropdown["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_buttonBar_Scene1_ButtonBar_0() : *
      {
         try
         {
            this.buttonBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.buttonBar.autoSize = "center";
         this.buttonBar.buttonWidth = 0;
         this.buttonBar.direction = "vertical";
         this.buttonBar.enabled = true;
         this.buttonBar.enableInitCallback = false;
         this.buttonBar.focusable = true;
         this.buttonBar.itemRendererName = "TitleButtonMC";
         this.buttonBar.spacing = 0;
         this.buttonBar.visible = true;
         try
         {
            this.buttonBar["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function frame1() : *
      {
         this.itemsData = new Array();
         this.i = 1;
         while(this.i < 5)
         {
            this.itemsData.push({
               "label":"Item " + this.i,
               "index":this.i
            });
            this.i++;
         }
         this.buttonBar.dataProvider = new DataProvider(this.itemsData);
         this.buttonBar.validateNow();
         this.NewScrollingList.dataProvider = new DataProvider(this.itemsData);
         this.NewScrollingList.selectedIndex = 0;
         this.NewScrollingList.invalidateSize();
         this.NewScrollingList.validateNow();
         this.dropdown.dataProvider = new DataProvider(this.itemsData);
         this.dropdown.selectedIndex = 0;
         this.optionStepper.dataProvider = new DataProvider(this.itemsData);
         this.optionStepper.selectedIndex = 0;
         this.subHeader.text = "TESTING SUBHEADER";
         this.ServerBrowserHeader.text = "TESTING HEADER";
      }
   }
}
