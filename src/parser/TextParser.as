package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import handler.GettableHandler;
	import handler.InventoryHandler;
	import handler.PersonHandler;
	import objects.npcs.Parrot;
	import objects.rooms.BedRoom;
	
	import handler.RoomHandler;
	import objects.Gettable;
	import objects.Person;
	import objects.Room;

	
	public class TextParser extends EventDispatcher
	{
		private var inputCommand:String;
		public var roomHandler:RoomHandler;
		public var inventoryHandler:InventoryHandler;
		//private var personHandler:PersonHandler;  Room handler handles npcs
		private var gettableHandler:GettableHandler;
		
		private var objectLibrary:ObjectLibrary = new ObjectLibrary();
		private var _parrot:Parrot;
		
		function TextParser()
		{
			roomHandler = new RoomHandler();
			roomHandler.loadRoom(new BedRoom);
			inventoryHandler = new InventoryHandler();
			//personHandler = new PersonHandler;
			//gettableHandler = new GettableHandler;
		}
		 
		public function parseCommand(command:String):void
		{
			command = command.toLowerCase();
			inputCommand = command;
			if (command == null || command.length == 0)
			{
				this.dispatchEvent(new OutputEvent("", OutputEvent.OUTPUT));
				return;
			}
			var splitSpaces:Array = command.split(" ");
			switch (splitSpaces[0])
			{
				case "look":case "l":
					checkLookCommand(splitSpaces);
					break;
				case "go":
					if (!checkDirectionCommand(splitSpaces[1]))
						this.dispatchEvent(new OutputEvent("I don't see any " + splitSpaces[1] + " exit.\n", OutputEvent.OUTPUT));
					break;
				case "inventory":case "i":case "inv":
					var tr:String = roomHandler.gettableHandler.currentInventory(); 
					this.dispatchEvent(new OutputEvent(tr, OutputEvent.OUTPUT));
					break;
				case "get":case "g":
					checkGetCommand(splitSpaces);
					break;
				case "drop":case "d":
					checkDropCommand(splitSpaces);
					break;
				default:
					if (checkDirectionCommand(splitSpaces[0]))
						return;
					checkDynamicCommands(splitSpaces);
					break;
			}
			// Refreshes the rooms, npcs and gettables
			var refreshScreen:String = roomHandler.getDescription();
		}
		
// Get and drop items		
		private function checkDropCommand(command:Array):void
		{
			var object:* = roomHandler.gettableHandler.gettableArray;
			var pickedObject:String = inventoryHandler.moveItem(object, command[1], new InventoryHandler, roomHandler.room);
			if (pickedObject != null)
				this.dispatchEvent(new OutputEvent("You drop a " + pickedObject + ".\n", OutputEvent.OUTPUT));
			else
				this.dispatchEvent(new OutputEvent("I don't have any " + command[1] + " to drop.\n", OutputEvent.OUTPUT));
		}
		
		private function checkGetCommand(command:Array):void
		{
			var object:* = roomHandler.gettableHandler.gettableArray;
			var pickedObject:String = inventoryHandler.moveItem(object, command[1], roomHandler.room, new InventoryHandler);
			if (pickedObject != null)
				this.dispatchEvent(new OutputEvent("You get a " + pickedObject + ".\n", OutputEvent.OUTPUT));
			else
				this.dispatchEvent(new OutputEvent("I don't see any " + command[1] + " here to get.\n", OutputEvent.OUTPUT));
		}
		
// Look (at the room, or at objects)		
		private function checkLookCommand(command:Array):void
		{
			if (command.length == 1) // If not looking at an object, just return room description
			{
				var longStr:String = roomHandler.getDescription();
				this.dispatchEvent(new OutputEvent(longStr, OutputEvent.OUTPUT));
				return;
			}
			
			var newCommand:String = command[1]
			if (command[1] == "at")   // Accomodate for 'look <object>' and 'look at <object>'
				newCommand = command[2];
			
			if (checkInventory(newCommand)) 
				return; 
			if (checkForNpcs(newCommand))  // If the player is looking at NPCs, will return true. Halt this conditional
				return;
			if (checkForGettables(newCommand))  // Same deal as above, but with gettable items
				return; 
			if (checkForRoomItems(newCommand)) 
				return; 
			
			this.dispatchEvent(new OutputEvent("I don't see any " + newCommand + " here.\n", OutputEvent.OUTPUT));
			return;
		}
		
		private function checkInventory(command:String):Boolean
		{
			var object:* = inventoryHandler.inventory; // Look for gettable objects with a location of 'inventory'
			var pickedObject:String = inventoryHandler.checkItemExists(object, command, new InventoryHandler);;
			if (pickedObject != null)
			{
				this.dispatchEvent(new OutputEvent(pickedObject + "\n", OutputEvent.OUTPUT));
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function checkForNpcs(command:String):Boolean
		{
			var object:* = roomHandler.personHandler.personArray; // Look for npc objects with a location of this room
			var pickedObject:String = inventoryHandler.checkItemExists(object, command, roomHandler.room);;
			if (pickedObject != null)
			{
				this.dispatchEvent(new OutputEvent(pickedObject + "\n", OutputEvent.OUTPUT));
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function checkForGettables(command:String):Boolean
		{
			var object:* = roomHandler.gettableHandler.gettableArray; // Look for gettable objects with a location of this room
			var pickedObject:String = inventoryHandler.checkItemExists(object, command, roomHandler.room);;
			if (pickedObject != null)
			{
				this.dispatchEvent(new OutputEvent(pickedObject + "\n", OutputEvent.OUTPUT));
				return true;
			}
			else
			{
				return false;
			}
		}	
		
		private function checkForRoomItems(command:String):Boolean
		{
			var itemObject:* = roomHandler.items; // Check if the second word matches the room's items 
			for (var i:* in itemObject) 
			{
				if (command == i) 
				{
					this.dispatchEvent(new OutputEvent(itemObject[i] + "\n", OutputEvent.OUTPUT));
					return true;
				}
			}
			
			return false;
		}
		
// Move between rooms
		private function checkDirectionCommand(newCommand:String):Boolean
		{			
			var obj:* = roomHandler.exits; // Check if the command matches the exits of the room.
			for (var i:* in obj) 
			{
				if (newCommand == i)
				{
					var mainClass:Class = getDefinitionByName(obj[i]) as Class; // Change the room to the one matching the exit
					roomHandler.loadRoom(new mainClass as Room);
					
					var longStr:String = "You leave out the " + newCommand + " exit. \n" + roomHandler.getDescription(); // Then fetch the new description
					this.dispatchEvent(new OutputEvent(longStr, OutputEvent.OUTPUT));
					return true;
				}
			}
			
			return false;
		}
		
// Dynamic commands (action commands attached to either npcs in the room or items in the inventory) 
		private function checkDynamicCommands(command:Array):void
		{
			if (checkRoomActions()) 
				return;
			if (checkNpcActions())
				return;		
			if (checkGettableActions())
				return;	
				
			var errorMsg:String = "I don't know how to " + inputCommand + ".\n";
			this.dispatchEvent(new OutputEvent(errorMsg, OutputEvent.OUTPUT));
		}
		
		private function checkGettableActions():Boolean
		{
			var parent:* = inventoryHandler.inventory;
			
			for (var i:* in parent)
			{
				var mainClass:Class = getDefinitionByName(parent[i].object) as Class; // Change the room to the one matching the exit
				var child:* = (new mainClass as Gettable);
				if (inputCommand == child.action.action)
				{
					this.dispatchEvent(new OutputEvent("Action matches that of an inventory item. \n", OutputEvent.OUTPUT));
					return true;
				}
			}
			return false;
		}
		
		
		private function checkRoomActions():Boolean
		{
			if (roomHandler.action != null)
			{
				if (inputCommand == roomHandler.action.action)  // If the command matches the action attached to this room
				{// We can handle it this way since we can only ever be in a single room at a single time
					this.dispatchEvent(new OutputEvent(roomHandler.getResponse(roomHandler.action.response) + "\n", OutputEvent.OUTPUT));
					return true;
				}
			}
			return false;
		}
		
		private function checkNpcActions():Boolean 
		{
			if (roomHandler.npcsThisRoom.length > 0) // If there is an NPC in the room
			{
				for (var i:* in roomHandler.npcsThisRoom)
				{
					if (roomHandler.npcsThisRoom[i].action != null) // Check if any of the NPCs in the room have an action
					{
						var npcAction:* = roomHandler.npcsThisRoom[i].action;
						if (inputCommand == npcAction.action) // Have to pass through the desired function since there can be multiple NPCs in a room
						{ 
							this.dispatchEvent(new OutputEvent(roomHandler.getResponse(npcAction.response) + "\n", OutputEvent.OUTPUT));
							return true;
						}
					}
				}
			}
			return false;
		}
		
	}
	
}