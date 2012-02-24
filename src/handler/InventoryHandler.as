package handler 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import objects.Gettable;

	public class InventoryHandler
	{
		public var inventory:Array = [];
		
		function InventoryHandler()
		{
		}
		
		public function moveItem(object:*, command:String, oldLocation:*, newLocation:*):String
		{
			if (!(oldLocation is String))
				oldLocation = getQualifiedClassName(oldLocation);
			if (!(newLocation is String))
				newLocation = getQualifiedClassName(newLocation);	
				
			for (var i:* in object) // Iterate through all the objects in existance
			{
				if (object[i].location == oldLocation)  // Find all objects that are in this current room
				{
					var gettableObj:Class = getDefinitionByName(object[i].object) as Class;
					var child:* = new gettableObj;
					for (var j:* in child.alias)  // Then iterate all the aliases for that object
					{
						if (command == child.alias[j])  // If matching, change the object's location to the new, target location
						{
							updateInventory(object[i], newLocation);
							object[i].location = newLocation;
							return child.shortDesc;
						}
					}
				}
			}
			return null;
		}
		
		public function checkItemExists(object:*, command:String, location:* ):String  // Use for looking at objects
		{
			if (!(location is String))
				location = getQualifiedClassName(location);
			
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
		
		public function refreshInventory(object:*):void  // Doesn't work. This should be rechecking the gettable lists and updating. Deleting item in gettable list does not delete from inventory
		{
			var tempInventory:Array = [];
			
			for (var i:* in object) // Iterate through all the objects in existance
			{
				//trace(" rhrh  " + i);
				if (object[i].location == getQualifiedClassName(this))
				{
					//trace("     pushing "+ object[i].object + " : " +object[i].location);
					tempInventory.push(object[i]);
				}
			}
			
			inventory = tempInventory;
		}
		
		private function updateInventory(object:*, location:String):void 
		{
			if (location == getQualifiedClassName(this))  // If the item is being moved to the inventory, pop it into here
			{
				inventory.push(object);
			}
			else // The item is being moved to a different room, so delete it from the array
			{
				for (var i:* in inventory)
				{
					if (object.object == inventory[i].object)
						inventory.splice(i, 1);
				}
			}
		}
		
	}
	
}