package handler 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import objects.Gettable;
	import objects.Person;
	import parser.Utils;
	import signals.DialogueEvent;

	public class GettableHandler extends EventDispatcher
	{
		public var gettableArray:Array = [];
		
		function GettableHandler()
		{
		}
		
		public function currentInventory():String
		{
			var td:Array = gettablesThisRoom(InventoryHolder);
			if (td.length == 0) 
				return "You are not carrying anything.";
				
			var tr:String = Utils.listGettables(td);
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
			
			checkAddedToInventory(getObj, loc);
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
					checkRemovedInventory(gettableArray[i].object, gettableArray[i].location);
					gettableArray.splice(i, 1);   // This deletes the item and allows it to reappear by visiting the room or executing the requisite creation command
					return; 
				}
			}	
		}
		
		public function moveGettable(getObj:*, oldLocation:*, newLocation:*):void
		{
			if (!(oldLocation is String))
				oldLocation = getQualifiedClassName(oldLocation);
			if (!(newLocation is String))
				newLocation = getQualifiedClassName(newLocation);	
			if (!(getObj is String))
				getObj = getQualifiedClassName(getObj);
				
			for (var i:* in gettableArray) // Iterate through all the objects in existance
			{
				if (gettableArray[i].object == getObj && gettableArray[i].location == oldLocation)  // Find all objects that are in this current room
				{
					checkAddedToInventory(getObj, newLocation);
					checkRemovedInventory(getObj, oldLocation);
					gettableArray[i].location = newLocation;
					return;
				}
			}
		}
		
		private function checkAddedToInventory(object:String, location:String):void
		{
			if (location == getQualifiedClassName(InventoryHolder))
				this.dispatchEvent(new DialogueEvent(getObjectName(object) + ' has been added to your inventory.', DialogueEvent.OUTPUT)); 
		}
		
		private function checkRemovedInventory(object:String, location:String):void
		{
			if (location == getQualifiedClassName(InventoryHolder))
				this.dispatchEvent(new DialogueEvent(getObjectName(object) + ' has been removed from your inventory.', DialogueEvent.OUTPUT)); 
		}
		
		public function checkItemExists(command:String, loc:*=null):String   // Checks whether an input command matches any object aliases and returns the appropriate object
		{
			if (loc != null)
			{
				if (!(loc is String))
					loc = getQualifiedClassName(loc);
			}
			
			for (var i:* in gettableArray) // Iterate through all the objects in existance
			{
				var gettableObj:Class = getDefinitionByName(gettableArray[i].object) as Class;
				var child:* = new gettableObj;
				for (var j:* in child.alias)  // Then iterate all the aliases for that object
				{
					if (command == child.alias[j])  // If the inputted command matches any of the object's aliases
					{
						if (loc == null)   // If no location parameter specified, return true
						{
							return gettableArray[i].object;
						}
						else
						{
							if (gettableArray[i].location == loc)  // Otherwise, also check if the object's location matches the parameter
								return gettableArray[i].object;
						}
					}
				}
			}
			
			return null;
		}
		
		public function getObjectName(getObj:*):String
		{
			if (!(getObj is String))
					getObj = getQualifiedClassName(getObj);
			
			try
			{
				var gettableObj:Class = getDefinitionByName(getObj) as Class;
				var child:* = new gettableObj;
				return child.shortDesc;
			}
			catch (error:Error)
			{
				trace(error.message);
			}
			return null;
		}
		
		public function getObjectDescript(getObj:*):String
		{
			if (!(getObj is String))
					getObj = getQualifiedClassName(getObj);
			
			try
			{
				var gettableObj:Class = getDefinitionByName(getObj) as Class;
				var child:* = new gettableObj;
				return child.longDesc;
			}
			catch (error:Error)
			{
				trace(error.message);
			}
			return null;
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
		
		public function searchGettables(getObj:*):Boolean
		{
			if (!(getObj is String))
					getObj = getQualifiedClassName(getObj);
			
			for (var i:* in gettableArray)
			{
				if (getObj == gettableArray[i].object)
					return true;
			}
			
			return false;
		}
		
	}
	
}