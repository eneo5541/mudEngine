package objects 
{

	public class Room 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var npcs:*;
		public var gettables:*;
		
		// These should be arrays, item would refer only to items in the description, not items in the room
		//public var item:Array<Items>;
		//public var exit:Array<Exits>;
		//public var cloneObject:Array<Objects>;
		// This would look for a specific action (eg: search rock) and then execute the function attached
		//public var action:Function;
 
		function Room()
		{			
			setExits();	
			setNpcs();
			setGettables();
			setItems();
			setShortDesc();
			setLongDesc();
		}
		// Extend the room object, then override these functions
		public function setExits():void
		{
			//exits = { exit:"objects.Room" };
		}
		
		public function setItems():void
		{
			//items = { item:"A non-descript item." };
		}
		
		public function setGettables():void
		{
			//gettables = { Gettable:"objects.Gettable" };
		}
		
		public function setShortDesc():void
		{
			//shortDesc = "Short.";
		}
		
		public function setNpcs():void
		{
			//npcs = { Person:"objects.Person" };
		}
		
		public function setLongDesc():void
		{
			//longDesc = "This is a long description";
		}
		
	}


}