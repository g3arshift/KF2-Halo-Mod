package scaleform.clik.utils
{
   import flash.utils.Dictionary;
   
   public class WeakRefDictionary
   {
       
      
      protected var _dictionary:Dictionary;
      
      public function WeakRefDictionary()
      {
         super();
         this._dictionary = new Dictionary(true);
      }
      
      public function setValue(param1:Object, param2:Object) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in this._dictionary)
         {
            if(param1 == this._dictionary[_loc3_])
            {
               this._dictionary[_loc3_] = null;
            }
         }
         this._dictionary[param2] = param1;
      }
      
      public function getValue(param1:Object) : Object
      {
         var _loc2_:* = null;
         for(_loc2_ in this._dictionary)
         {
            if(param1 == this._dictionary[_loc2_])
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
