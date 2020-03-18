package com.greensock.easing
{
   public final class CircOut extends Ease
   {
      
      public static var ease:com.greensock.easing.CircOut = new com.greensock.easing.CircOut();
       
      
      public function CircOut()
      {
         super();
      }
      
      override public function getRatio(param1:Number) : Number
      {
         return Math.sqrt(1 - param1-- * param1);
      }
   }
}
