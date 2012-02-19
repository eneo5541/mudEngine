package parser 
{
   
	import flash.events.Event;
   
	public class OutputEvent extends Event
	{
		public static const OUTPUT:String = "output";
		public var value:String;
		public function OutputEvent(value:String, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
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