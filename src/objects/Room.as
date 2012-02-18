package objects 
{
	import handler.ListHandler;

	public class Room 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var npcs:*;
		public var object:*;
		
		private var listHandler:ListHandler;
		// These should be arrays, item would refer only to items in the description, not items in the room
		//public var item:Array<Items>;
		//public var exit:Array<Exits>;
		//public var cloneObject:Array<Objects>;
		// This would look for a specific action (eg: search rock) and then execute the function attached
		//public var action:Function;
 
		function Room()
		{
			listHandler = new ListHandler();
			
			setExits();	
			setNpcs();
			setObject();
			setItems();
			setShortDesc();
			setLongDesc();
			
			addExits();
			addNpcs();
			addObject();
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
		
		public function setObject():void
		{
			//object = { Object:"objects.Item" };
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
			// Must manually add this to each class that overrides setLongDesc()
		}
		
		public function addExits():void
		{
			if (exits == null) return;
			// This adds a list of the values in the exit object to the description. 			
			var obj:* = exits;
			var objectList:Array = [];
			
			for (var i:* in obj) 
				objectList.push(i);
			
			var tr:String = listHandler.listExits(objectList);
			longDesc += "\nThere are exits to the " + tr;
		}
		
		public function addNpcs():void
		{
			if (npcs == null) return;
			
			var obj:* = npcs;
			var objectList:Array = [];
			
			for (var i:* in obj) 
				objectList.push(i);
			
			var tr:String = listHandler.listNpcs(objectList);
			longDesc += "\n" + tr;
		}
		
		public function addObject():void
		{
		/*	if (object == null) return;	
			
			var obj:* = object;
			var objectList:Array = [];
			
			for (var i:* in obj) 
				objectList.push(i);
			
			var tr:String = listHandler.listObjects(objectList);
			longDesc += "\n" + tr;*/
		}
		
	}


}