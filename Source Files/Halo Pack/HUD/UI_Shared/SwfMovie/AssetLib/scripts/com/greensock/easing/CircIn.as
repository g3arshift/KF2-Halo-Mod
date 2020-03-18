package com.greensock.easing
{
   public final class CircIn extends Ease
   {
      
      public static var ease:com.greensock.easing.CircIn = new com.greensock.easing.CircIn();
       
      
      public function CircIn()
      {
         super();
      }
      
      override public function getRatio(param1:Number) : Number
      {
         return -(Math.sqrt(1 - param1 * param1) - 1);
      }
   }
}
