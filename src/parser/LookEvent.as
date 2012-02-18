package parser 
{
   
   import flash.events.Event;
   
   public class LookEvent extends Event {
      
      public static const LOOK:String = "look";
      
      public function LookEvent(type:String){
         super(type);
      }
      
      public override function clone():Event {
         return new LookEvent(type);
      }
   }
}