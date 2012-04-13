package signals 
{
   
	import flash.events.Event;
   
	public class ColourEvent extends Event
	{
		public static const OUTPUT:String = "changeColour";
		public var value:String;
		public function ColourEvent(value:String, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
		
		public override function clone():Event
		{
			return new ColourEvent(value, type, bubbles, cancelable);
		}
	}
}