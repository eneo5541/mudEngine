package objects 
{
	/**
	 * ...
	 * @author eric
	 */
	public class Room 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		// These should be arrays, item would refer only to items in the description, not items in the room
		//public var item:Array<Items>;
		//public var exit:Array<Exits>;
		//public var cloneObject:Array<Objects>;
		// This would look for a specific action (eg: search rock) and then execute the function attached
		//public var action:Function;
 
		function Room()
		{
			setShortDesc();
			setLongDesc();
			setExits();
		}
		
		public function setShortDesc():void
		{
			shortDesc = "This is a short description";
		}
		
		public function setLongDesc():void
		{
			longDesc = "This is a longer description";
		}
		
		public function setExits():void
		{
			exits = { "exit":objects.Room };
		}
		
	}


}