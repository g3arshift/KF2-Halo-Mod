package com.greensock.easing
{
   public final class ExpoInOut extends Ease
   {
      
      public static var ease:com.greensock.easing.ExpoInOut = new com.greensock.easing.ExpoInOut();
       
      
      public function ExpoInOut()
      {
         super();
      }
      
      override public function getRatio(param1:Number) : Number
      {
         return (param1 = Number(param1 * 2)) < 1?Number(0.5 * Math.pow(2,10 * (param1 - 1))):Number(0.5 * (2 - Math.pow(2,-10 * (param1 - 1))));
      }
   }
}
