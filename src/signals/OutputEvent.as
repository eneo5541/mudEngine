package signals 
{
   
	import flash.events.Event;
   
	public class OutputEvent extends Event
	{
		public static const OUTPUT:String = "output";
		public static const LOOK:String = "look";
		public var value:String;
		public function OutputEvent(value:String, type:String, bubbles:Boolean = true, cancelable:Boolean = true)
		{
			super(type, bubbles, cancelable);
			this.value = value;  
		}
		
		public override function clone():Event
		{
			return new OutputEvent(value, type, bubbles, cancelable);
		}
	}
}