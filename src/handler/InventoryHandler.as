package handler 
{
	import flash.utils.getDefinitionByName;
	import objects.Gettable;

	public class InventoryHandler
	{
		public var inventory:Array = [];
		
		function InventoryHandler()
		{
		}
		
		public function addGettable(gettable:Gettable):void
		{
			inventory.push(gettable);
		}
		
		public function moveItem(object:*, command:String, oldLocation:String, newLocation:String):String
		{
			for (var i:* in object) // Iterate through all the objects in existance
			{
				if (object[i].location == oldLocation)  // Find all objects that are in this current room
				{
					var gettableObj:Class = getDefinitionByName(object[i].object) as Class;
					var child:* = new gettableObj;
					for (var j:* in child.alias)  // Then iterate all the aliases for that object
					{
						if (command == child.alias[j])  // If matching, change the object's location to inventory
						{
							object[i].location = newLocation;
							return child.shortDesc;
						}
					}
				}
			}
			return null;
		}
		
		public function checkItemExists(object:*, command:String, location:String ):String  // Use for looking at objects
		{
			for (var i:* in object) 
			{
				if (object[i].location == location) // Check if the object is at the location
				{
					var tempObj:Class = getDefinitionByName(object[i].object) as Class;
					var child:* = new tempObj;
					for (var j:* in child.alias)  // Check if the command entered matches the object's aliases
					{
						if (command == child.alias[j])
							return child.longDesc;
					}
				}
			}
			
			return null;
		}
		
	}
	
}