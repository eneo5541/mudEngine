package parser 
{
   
	import flash.events.Event;
   
	public class DialogueEvent extends Event
	{
		public static const OUTPUT:String = "dialogue";
		public var value:String;
		public function DialogueEvent(value:String, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.value = "<p>" + value + "</p>";  
		}
		
		public override function clone():Event
		{
			return new DialogueEvent(value, type, bubbles, cancelable);
		}
	}
}