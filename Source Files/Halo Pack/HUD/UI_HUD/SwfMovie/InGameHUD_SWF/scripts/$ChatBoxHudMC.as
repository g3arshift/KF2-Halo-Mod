package
{
   import tripwire.widgets.PlayerChatWidget;
   
   public dynamic class $ChatBoxHudMC extends PlayerChatWidget
   {
       
      
      public function $ChatBoxHudMC()
      {
         super();
         this.__setProp_ChatHistory_$ChatBoxHudMC_History_0();
         this.__setProp_ChatInputField_$ChatBoxHudMC_Input_0();
      }
      
      function __setProp_ChatHistory_$ChatBoxHudMC_History_0() : *
      {
         try
         {
            ChatHistory["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         ChatHistory.enabled = true;
         ChatHistory.enableInitCallback = false;
         ChatHistory.focusable = true;
         ChatHistory.itemRendererName = "";
         ChatHistory.itemRendererInstanceName = "chatLine";
         ChatHistory.margin = 0;
         ChatHistory.inspectablePadding = {
            "top":0,
            "right":0,
            "bottom":0,
            "left":0
         };
         ChatHistory.rowHeight = 0;
         ChatHistory.scrollBar = "ChatScrollBar";
         ChatHistory.visible = true;
         ChatHistory.wrapping = "normal";
         try
         {
            ChatHistory["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_ChatInputField_$ChatBoxHudMC_Input_0() : *
      {
         try
         {
            ChatInputField["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         ChatInputField.actAsButton = true;
         ChatInputField.defaultText = "";
         ChatInputField.displayAsPassword = false;
         ChatInputField.editable = true;
         ChatInputField.enabled = true;
         ChatInputField.enableInitCallback = false;
         ChatInputField.focusable = true;
         ChatInputField.maxChars = 128;
         ChatInputField.text = "";
         ChatInputField.visible = true;
         try
         {
            ChatInputField["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
