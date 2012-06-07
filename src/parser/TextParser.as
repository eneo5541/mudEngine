package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import handler.GettableHandler;
	import handler.InventoryHolder;
	import handler.PersonHandler;
	import handler.RoomHandler;
	
	import objects.Gettable;
	import objects.Person;
	import objects.Room;
	
	import signals.DialogueEvent;
	import signals.OutputEvent;

	
	public class TextParser extends EventDispatcher
	{
		public var roomHandler:RoomHandler;
		private var inputCommand:String;
		private var isWhiteText:Boolean = true;
		
		function TextParser(targetRoom:String)
		{
			roomHandler = new RoomHandler();
			
			var tempRoom:Class = getDefinitionByName(targetRoom) as Class;
			roomHandler.loadRoom(new tempRoom);
			
			roomHandler.addEventListener(DialogueEvent.OUTPUT, dialogueHandler);
		}
		
		private function dialogueHandler(e:DialogueEvent):void
		{
			outputHandler(e.value);
		}

		private function outputHandler(textOutput:String):void
		{
			this.dispatchEvent(new OutputEvent(textOutput, OutputEvent.OUTPUT));
		}
		
		public function parseCommand(command:String):void
		{
			if (command == null || command.length == 0)
				return;
			
			var splitWords:Array = command.split(';');
			for (var i:* in splitWords)
			{
				if (i > 11)
				{
					outputHandler('You cannot queue more than 12 commands. Aborting command.');
					continue;
				}
				executeCommand(splitWords[i]);
			}
		}
		
		public function executeCommand(command:String):void
		{	
			inputCommand = command = command.toLowerCase();
			
			var splitSpaces:Array = command.split(" ");
			switch (splitSpaces[0])
			{
				case "look":case "l":
					checkLookCommand(splitSpaces);
					break;
				case "go":case "walk":
					if (!checkDirectionCommand(splitSpaces[1]))
						outputHandler("You don't see any " + splitSpaces[1] + " exit.");
					break;
				case "inventory":case "i":case "inv":
					var inventoryList:String = roomHandler.gettableHandler.currentInventory(); 
					outputHandler(inventoryList);
					break;
				case "get":case "g":case "take":
					checkGetCommand(splitSpaces);
					break;
				case "drop":case "d":case "throw":
					checkDropCommand(splitSpaces);
					break;
				default:
					if (!checkDirectionCommand(splitSpaces[0]))   // Check if command is a direction command
						checkDynamicCommands(splitSpaces);  // If not, check if it is a dynamic command
					break;
			}
		}
		
// Get and drop items		
		private function checkDropCommand(command:Array):void
		{
			var objectExists:String = roomHandler.gettableHandler.checkItemExists(command[1], InventoryHolder); // Check if there is an item of the same input command in the inventory
			if (objectExists != null)
			{
				roomHandler.gettableHandler.moveGettable(objectExists, roomHandler.room); // Do not need to explicitly state an origin, since objectExists already checks whether the object is a valid target.
				outputHandler("You drop a " + roomHandler.gettableHandler.getObjectName(objectExists) + ".");
			}
			else
			{
				outputHandler("You don't have any " + command[1] + " to drop.");
			}
		}
		
		private function checkGetCommand(command:Array):void
		{
			var objectExists:String = roomHandler.gettableHandler.checkItemExists(command[1], roomHandler.room); // Check if there is an item of the same input command in the room
			if (objectExists != null)
			{
				if (roomHandler.gettableHandler.checkGettableLocation(InventoryHolder).length > 4) 
				{
					outputHandler("You are carrying too many things. Drop something to free up inventory space.");
				}
				else
				{
					roomHandler.gettableHandler.moveGettable(objectExists, InventoryHolder); // Do not need to explicitly state an origin, since objectExists already checks whether the object is a valid target.
					outputHandler("You get a " + roomHandler.gettableHandler.getObjectName(objectExists) + ".");
				}
			}
			else
			{
				outputHandler("You don't see any " + command[1] + " here to get.");
			}
		}
		
// Look (at the room, or at objects)		
		private function checkLookCommand(command:Array):void
		{
			if (command.length == 1) // If not looking at an object, just return room description
			{
				var longStr:String = roomHandler.getDescription();
				outputHandler(longStr);  // Special signal that does not added HTML tags (since room already adds HTML tags)
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
			
			outputHandler("You don't see any " + newCommand + " here.");
			return;
		}
		
		private function checkInventory(command:String):Boolean
		{
			var objectExists:String = roomHandler.gettableHandler.checkItemExists(command, InventoryHolder);
			if (objectExists != null)
			{
				outputHandler(roomHandler.gettableHandler.getObjectDescript(objectExists));
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function checkForNpcs(command:String):Boolean
		{
			var objectExists:String = roomHandler.personHandler.checkNPCExists(command, roomHandler.room);
			if (objectExists != null)
			{
				outputHandler(roomHandler.personHandler.getNPCDescript(objectExists));
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function checkForGettables(command:String):Boolean
		{
			var objectExists:String = roomHandler.gettableHandler.checkItemExists(command, roomHandler.room);
			if (objectExists != null)
			{
				outputHandler(roomHandler.gettableHandler.getObjectDescript(objectExists));
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
					outputHandler(itemObject[i]);
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
					var className:String = getQualifiedClassName(obj[i]);
					var mainClass:Class = getDefinitionByName(className) as Class; // Change the room to the one matching the exit
					roomHandler.loadRoom(new mainClass as Room);
					
					var longStr:String = "You leave out the " + newCommand + " exit."; // Then fetch the new description
					outputHandler(longStr);
					var roomStr:String = roomHandler.getDescription();  
					outputHandler(roomStr, OutputEvent.OUTPUT);
					return true;
				}
			}
			
			return false;
		}
		
// Dynamic commands (action commands attached to either npcs in the room or items in the inventory) 
		private function checkDynamicCommands(command:Array):void
		{
			if (checkNpcActions())
				return;		
			if (checkGettableActions())
				return;	
			if (checkRoomActions()) 
				return;
			
			var errorMsg:String = "You don't know how to " + inputCommand + ".";
			outputHandler(errorMsg);
		}
		
		
		private function checkGettableActions():Boolean
		{
			var parent:* = roomHandler.gettableHandler.checkGettableLocation(InventoryHolder);
			
			for (var i:* in parent)
			{
				var mainClass:Class = getDefinitionByName(parent[i]) as Class; 
				var child:* = (new mainClass as Gettable);
				if (child.action != null) 
				{
					for (var j:* in child.action.action)  
					{
						if (inputCommand == child.action.action[j].toLowerCase())
						{
							roomHandler.getResponse(child.action);
							return true;
						}
					}
				}
			}
			return false;
		}
		
		private function checkRoomActions():Boolean
		{
			if (roomHandler.action != null)
			{
				for (var i:* in roomHandler.action.action)  // Checks for all alternative action commands for each particular action
				{
					if (inputCommand == roomHandler.action.action[i].toLowerCase())  // If the command matches the action attached to this room
					{// We can handle it this way since we can only ever be in a single room at a single time
						roomHandler.getResponse(roomHandler.action);
						return true;
					}
				}
			}
			return false;
		}
		
		private function checkNpcActions():Boolean 
		{
			for (var i:* in roomHandler.npcsThisRoom) // If there is an NPC in the room
			{
				if (roomHandler.npcsThisRoom[i].action != null) // Check if any of the NPCs in the room have an action
				{
					for (var j:* in roomHandler.npcsThisRoom[i].action.action)
					{
						var npcAction:* = roomHandler.npcsThisRoom[i].action;
						if (inputCommand == npcAction.action[j].toLowerCase()) // Have to pass through the desired function since there can be multiple NPCs in a room
						{ 
							roomHandler.getResponse(npcAction);
							return true;
						}
					}
				}
			}
			return false;
		}		
		
	}
	
}