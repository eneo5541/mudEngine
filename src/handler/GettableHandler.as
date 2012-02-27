package handler 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import objects.Gettable;
	import objects.Person;

	public class GettableHandler
	{
		public var gettableArray:Array = [];
		private var listHandler:ListHandler = new ListHandler();
		
		function GettableHandler()
		{
		}
		
		public function currentInventory():String
		{
			var td:Array = gettablesThisRoom(new InventoryHandler);
			if (td.length == 0) 
				return "You are not carrying anything.";
				
			var tr:String = listHandler.listGettables(td);
			return "You are carrying: \n" + tr;
		}
		
		// This pushes an item to the gettableArray that holds ALL gettables in the game and their location
		public function addGettable(getObj:*, loc:*):void // Gettables can exist but not necessarily be placed in the game yet
		{
			if (!(getObj is String)) 
				getObj = getQualifiedClassName(getObj);
				
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].object == getObj)  // If the object is already in the array, do not add it.
					return;  // This is necessary, or existing objects could be duplicated by moving rooms back and forth
			}
			
			if (!(loc is String))   // Convert the location to a string for storage
				loc = getQualifiedClassName(loc);
			
			gettableArray.push( { object:getObj, location:loc } );
		}
		
		public function removeGettable(getObj:*):void  // Similar to add command, but removes item from existance anywhere. 
		{
			if (!(getObj is String))   // Convert the location to a string for storage
				getObj = getQualifiedClassName(getObj);
				
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].object == getObj)  // If the object exists, delete it.
				{
					gettableArray.splice(i, 1);   // This deletes the item and allows it to reappear by visiting the room or executing the requisite creation command
					//gettableArray[i].location = "DUMMY";  // This will make the object never reappear. It will not be readded, since it exists, and is bound to a dummy location
					return; 
				}
			}	
		}
		
		public function gettablesThisRoom(room:*):Array
		{
			var gettablesInRoom:Array = checkGettableLocation(room);  // Return gettables in the room
			var shortDescripts:Array = [];
			
			for (var i:* in gettablesInRoom)
			{
				var gettableClass:Class = getDefinitionByName(gettablesInRoom[i]) as Class;  // Then convert them to classes and get the short desc for them
				shortDescripts.push((new gettableClass).shortDesc);
			}
			return shortDescripts;
		}
		
		public function checkGettableLocation(loc:*):Array
		{
			if (!(loc is String))
				loc = getQualifiedClassName(loc);
				
			var gettablesInLoc:Array = [];
			
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].location == loc)  // Return gettables that have the same location
				{
					var gettableClass:Class = getDefinitionByName(gettableArray[i].object) as Class;
					gettablesInLoc.push(getQualifiedClassName(gettableClass));
				}
			}
			
			return gettablesInLoc;
		}
		
	}
	
}