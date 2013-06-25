package handlers 
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import handlers.holders.InventoryHolder;
	import parser.Utils;
	import signals.OutputEvent;

	public class GettableHandler extends Sprite
	{
		public var gettableArray:Array = [];
		
		function GettableHandler()
		{
		}
		
		public function currentInventory():String
		{
			var allInventory:Array = gettablesThisRoom(InventoryHolder);
			if (allInventory.length == 0) 
				return "You are not carrying anything.";
				
			var listInventory:String = Utils.listGettables(allInventory);
			return "You are carrying: \n" + listInventory;
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
		
		public function moveGettable(getObj:*, loc:*):void
		{
			if (!(getObj is String)) 
				getObj = getQualifiedClassName(getObj);
			
			var getIndex:int = -1;
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].object == getObj) 
					getIndex = i;
			}
			if (getIndex < 0) return; // Do not run if the gettable does not exist
			
			if (!(loc is String)) 
				loc = getQualifiedClassName(loc);
			
			gettableArray[getIndex].location = loc;   // Go to the index of the gettable object and change the location.
		}
		
		private function checkAddedToInventory(object:String, location:String):void
		{
			if (location == getQualifiedClassName(InventoryHolder))
				this.dispatchEvent(new OutputEvent(getObjectName(object) + ' has been added to your inventory.', OutputEvent.OUTPUT));
		}
		
		private function checkRemovedInventory(object:String, location:String):void
		{
			if (location == getQualifiedClassName(InventoryHolder))
				this.dispatchEvent(new OutputEvent(getObjectName(object) + ' has been removed from your inventory.', OutputEvent.OUTPUT));
		}
		
		public function checkItemExists(command:String, loc:*=null):String   // Checks whether an input command matches any object aliases and returns the appropriate object
		{
			command = command.toLowerCase();
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
					if (command == child.alias[j].toLowerCase() || command == child.shortDesc.toLowerCase())  // If the inputted command matches any of the object's aliases
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
		
		public function isObjectGettable(getObj:*):Boolean
		{
			if (!(getObj is String))
				getObj = getQualifiedClassName(getObj);
			
			try
			{
				var gettableObj:Class = getDefinitionByName(getObj) as Class;
				var child:* = new gettableObj;
				return child.isGettable;
			}
			catch (error:Error)
			{
				trace(error.message);
			}
			return false;
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