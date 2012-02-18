package parser 
{
   
	import flash.events.Event;
   
	public class OutputEvent extends Event
	{
		public static const OUTPUT:String = "output";
		public var values:int;
		public function OutputEvent(values:int, type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.values = values;  
		}
		
		public override function clone():Event
		{
			return new OutputEvent(values, type, bubbles, cancelable);
		}
	}
}