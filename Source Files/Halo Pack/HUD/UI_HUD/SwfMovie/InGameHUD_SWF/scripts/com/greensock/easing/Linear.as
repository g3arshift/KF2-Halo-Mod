package com.greensock.easing
{
   public final class Linear extends Ease
   {
      
      public static var easeNone:com.greensock.easing.Linear = new com.greensock.easing.Linear();
      
      public static var ease:com.greensock.easing.Linear = easeNone;
      
      public static var easeIn:com.greensock.easing.Linear = easeNone;
      
      public static var easeOut:com.greensock.easing.Linear = easeNone;
      
      public static var easeInOut:com.greensock.easing.Linear = easeNone;
       
      
      public function Linear()
      {
         super(null,null,1,0);
      }
   }
}
