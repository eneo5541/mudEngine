package signals 
{
   
	import flash.events.Event;
	import objects.User;
   
	public class IntroEvent extends Event
	{
		public static const LOADGAME:String = "load";
		public static const STARTGAME:String = "intro";
		
		public var value:User;
		public function IntroEvent(value:*, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
		
		public override function clone():Event
		{
			return new IntroEvent(value, type, bubbles, cancelable);
		}
	}
}