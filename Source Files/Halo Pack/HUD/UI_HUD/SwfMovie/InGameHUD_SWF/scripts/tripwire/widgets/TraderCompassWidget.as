package tripwire.widgets
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   
   public class TraderCompassWidget extends UIComponent
   {
       
      
      private var _upArrow:MovieClip;
      
      private var _downArrow:MovieClip;
      
      private var _leftArrow:MovieClip;
      
      private var _rightArrow:MovieClip;
      
      private var _centralPing:MovieClip;
      
      private const Compass_Limit_From_Center:Number = 108;
      
      private const Compass_CenterPoint:Number = 128;
      
      public var CompassPingAnimContainer:MovieClip;
      
      public var CompassArrowAnimContainer:MovieClip;
      
      public var CompassInfoContainer:MovieClip;
      
      public function TraderCompassWidget()
      {
         super();
         _enableInitCallback = true;
         this.cachePingSymbols();
      }
      
      public function set traderText(param1:String) : void
      {
         this.CompassInfoContainer.TraderTF.text = param1;
      }
      
      private function cachePingSymbols() : void
      {
         this.CompassArrowAnimContainer.CompassLeftArrow.visible = false;
         this.CompassArrowAnimContainer.CompassRightArrow.visible = false;
         this.CompassArrowAnimContainer.CompassTopArrow.visible = false;
         this.CompassArrowAnimContainer.CompassBottomArrow.visible = false;
         this._centralPing = this.CompassPingAnimContainer.CompassPingContainer.CentralPing;
         this._downArrow = this.CompassPingAnimContainer.CompassPingContainer.DownArrow;
         this._upArrow = this.CompassPingAnimContainer.CompassPingContainer.UpArrow;
         this._leftArrow = this.CompassPingAnimContainer.CompassPingContainer.LeftArrow;
         this._rightArrow = this.CompassPingAnimContainer.CompassPingContainer.RightArrow;
      }
      
      public function set distanceToTrader(param1:int) : void
      {
         this.CompassInfoContainer.DistanceTF.text = param1 + "M";
         if(param1 < 0)
         {
            this.setArrowAppearance(false,false,false,false,false);
            this.setDistanceAppearance(false);
         }
         else
         {
            this.setDistanceAppearance(true);
         }
      }
      
      private function setDistanceAppearance(param1:Boolean) : void
      {
         this.CompassInfoContainer.DistanceTF.visible = param1;
         this.CompassInfoContainer.TraderTF.visible = param1;
      }
      
      private function setArrowAppearance(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         this._centralPing.visible = param1;
         this._upArrow.visible = param2;
         this._downArrow.visible = param3;
         this._leftArrow.visible = param4;
         this._rightArrow.visible = param5;
      }
      
      public function set traderAngle(param1:Number) : void
      {
         param1 = param1 * this.Compass_Limit_From_Center + this.Compass_CenterPoint;
         this.CompassPingAnimContainer.CompassPingContainer.x = param1;
      }
      
      public function set arrowDirection(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.setArrowAppearance(true,false,false,false,false);
               break;
            case 1:
               this.setArrowAppearance(false,true,false,false,false);
               break;
            case 2:
               this.setArrowAppearance(false,false,true,false,false);
               break;
            case 3:
               this.setArrowAppearance(false,false,false,true,false);
               break;
            case 4:
               this.setArrowAppearance(false,false,false,false,true);
         }
      }
   }
}
