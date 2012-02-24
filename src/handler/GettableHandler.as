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
				return "You are not carrying anything. \n";
				
			var tr:String = listHandler.listGettables(td);
			return "You are carrying:" + tr + "\n";
		}
		
		public function addGettable(getObj:String, loc:*):void
		{
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].object == getObj)  // If the object is already in the array, do not add it.
					return;  // This is necessary, or existing objects could be duplicated by moving rooms back and forth
			}
			
			var td:String = loc;
			if (!(loc is String))   // Convert the location to a string for storage
				td = getQualifiedClassName(loc);
			
			gettableArray.push( { object:getObj, location:td } );
		}
		
		public function removeGettable(getObj:String):void  // Similar to add command, but removes item from existance anywhere. 
		{
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
			if (!(room is String))
				room = getQualifiedClassName(room);
				
			var gettablesInRoom:Array = [];
			
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].location == room)  // If the object is in the given room, return it.
				{
					var gettableClass:Class = getDefinitionByName(gettableArray[i].object) as Class;
					gettablesInRoom.push((new gettableClass).shortDesc);
				}
			}
			
			return gettablesInRoom;
		}
		
	}
	
}