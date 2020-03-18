package com.greensock.easing
{
   public final class CircInOut extends Ease
   {
      
      public static var ease:com.greensock.easing.CircInOut = new com.greensock.easing.CircInOut();
       
      
      public function CircInOut()
      {
         super();
      }
      
      override public function getRatio(param1:Number) : Number
      {
         return (param1 = Number(param1 * 2)) < 1?Number(-0.5 * (Math.sqrt(1 - param1 * param1) - 1)):Number(0.5 * (Math.sqrt(1 - (param1 = Number(param1 - 2)) * param1) + 1));
      }
   }
}
