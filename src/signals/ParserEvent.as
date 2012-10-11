package signals 
{
   
	import flash.events.Event;
   
	public class ParserEvent extends Event
	{
		public static const COLOUR:String = "colour";
		public static const SHEET:String = "sheet";
		public static const INVENTORY:String = "inventory";
		
		public var value:*;
		public function ParserEvent(value:*, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
		
		public override function clone():Event
		{
			return new ParserEvent(value, type, bubbles, cancelable);
		}
	}
}