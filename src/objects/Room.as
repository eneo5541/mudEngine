package objects 
{

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
			setExits();
			setShortDesc();
			setLongDesc();
			
		}
		// Extend the room object, then override these functions
		public function setExits():void
		{
			exits = { exit:"objects.Room" };
		}
		public function setShortDesc():void
		{
			shortDesc = "Short.";
		}
		
		public function setLongDesc():void
		{
			longDesc = "This is a long description";
			// Must manually add this to each class that overrides setLongDesc()
			addExits();
		}
		
		public function addExits():void
		{
			if (exits == null) return;
			// This adds a list of the values in the exit object to the description. 
			var obj:* = exits;
			var exitString:String = "";
			
			for (var i:* in obj) 
			{
				exitString += i + ", ";
			}
			
			longDesc += "\nThere are exits to the " + exitString;
		}
		
	}


}