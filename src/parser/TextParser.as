package parser 
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import handlers.GettableHandler;
	import handlers.holders.InventoryHolder;
	import handlers.MapHandler;
	import handlers.SaveHandler;
	import handlers.RoomHandler;
	import objects.Container;
	import objects.Gettable;
	import objects.Room;
	import objects.rooms.house.Bedroom;
	import signals.OutputEvent;
	import signals.ParserEvent;
	
	
	public class TextParser extends Sprite
	{
		public var roomHandler:RoomHandler;
		public var sheet:Sheet;
		private var saveHandler:SaveHandler = new SaveHandler();
		private var inputCommand:String;
		private var isWhiteText:Boolean = true;
		private var _startingRoom:Bedroom = new Bedroom();  // This makes all the objects compile into the .swf, as they are all strongly referenced
		private var mapHandler:MapHandler = new MapHandler();
		
		function TextParser(targetRoom:String)  // Accepts a target room to start in, so we can load into a specific room
		{
			roomHandler = new RoomHandler();
			addChild(roomHandler);
			
			sheet = new Sheet();
			addChild(sheet);
			
			var tempRoom:Class = getDefinitionByName(targetRoom) as Class;
			roomHandler.loadRoom(new tempRoom);
			
			roomHandler.addEventListener(ParserEvent.SHEET, incrementExperience);
			roomHandler.addEventListener(OutputEvent.LOOK, lookHandler);
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
				case "get":case "take":
					checkGetCommand(splitSpaces);
					break;
				case "put":case "store":
					checkPutCommand(splitSpaces);
					break;
				case "drop":case "discard":
					checkDropCommand(splitSpaces);
					break;
				case "inventory":case "i":case "inv":
					outputHandler(roomHandler.gettableHandler.currentInventory());
					break;
				case "sheet":
					outputHandler(sheet.getSheet());
					break;
				case "save":
					saveHandler.saveGame(this);
					outputHandler("Saving the game...");
					break;
				case "colours":case "black":case "white":
					checkColours(splitSpaces);
					break;
				case "map":case "m":
					outputHandler(mapHandler.generateMap(_startingRoom, roomHandler.room));
					break;
				case "talk":case "speak":	
					checkConversations(splitSpaces);
					break;
				default:
					if (!checkDirectionCommand(splitSpaces[0]))   // Check if command is a direction command
						checkDynamicCommands(splitSpaces);  // If not, check if it is a dynamic command
					break;
			}
		}
		
// Drop items		
		private function checkDropCommand(command:Array):void
		{
			if (command.length == 1)
			{
				outputHandler("You don't have anything to drop.");  
				return;
			}
			
			var newCommand:String = inputCommand.substr(command[0].length+1, inputCommand.length);
			var objectExists:String = roomHandler.gettableHandler.checkItemExists(newCommand, InventoryHolder); // Check if there is an item of the same input command in the inventory
			if (objectExists != null)
			{
				roomHandler.gettableHandler.moveGettable(objectExists, roomHandler.room);
				outputHandler("You drop a " + Utils.getObjectShortDesc(objectExists) + ".");
				this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
			}
			else
			{
				outputHandler("You don't have any " + command[1] + " to drop.");
			}
		}
		
// Get items, from both ground and containers
		private function checkGetCommand(command:Array):void
		{
			var errorOutput:String = "";
			var itemName:String = inputCommand.substr(command[0].length + 1, inputCommand.length);
			var targetName:String = roomHandler.room;
			
			for (var i:* in command) 
			{
				if (inputCommand.indexOf(" from ") > -1)
				{
					itemName = inputCommand.substring(command[0].length + 1, inputCommand.indexOf(" from "));
					
					var targetExists:String = roomHandler.gettableHandler.checkItemExists(inputCommand.substring(inputCommand.indexOf(" from ") + 6, inputCommand.length), roomHandler.room);   // Check if the target we're trying to get the item to is in the same room
					if (targetExists != null)
					{
						var gettableObj:Class = getDefinitionByName(targetExists) as Class;   // If the target we're trying to get the item from is a container, use this object when we check the location of the item we're trying to get
						var child:* = new gettableObj;
						if (child is Container)
							targetName = targetExists;
					}
					break;
				}
			}
			
			errorOutput = "You don't see any " + itemName + " here to get.";
			
			if (command.length == 1)
			{
				errorOutput = "You don't have anything to get.";
			}
			else
			{
				var objectExists:String = roomHandler.gettableHandler.checkItemExists(itemName, targetName); // Check if there is an item of the same input command in the room
				if (objectExists != null)
				{
					if (roomHandler.gettableHandler.checkGettableLocation(InventoryHolder).length > 7) 
					{
						errorOutput = "You can only carry 8 items. Drop something to free up inventory space.";
					}
					else if (!roomHandler.gettableHandler.isObjectGettable(objectExists))
					{
						errorOutput = "You cannot get a " + Utils.getObjectShortDesc(objectExists) + ".";
					}
					else
					{
						roomHandler.gettableHandler.moveGettable(objectExists, InventoryHolder);
						outputHandler("You get a " + Utils.getObjectShortDesc(objectExists) + ".");
						this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
						return;
					}
				}
			}
			
			outputHandler(errorOutput);
		}
		
// Put items into containers
		private function checkPutCommand(command:Array):void
		{
			var errorOutput:String = "";
			var itemName:String = "";
			var targetName:String = "";
			
			for (var i:* in command) 
			{
				if (inputCommand.indexOf(" in ") > -1)
				{
					itemName = inputCommand.substring(command[0].length + 1, inputCommand.indexOf(" in "));
					targetName = inputCommand.substring(inputCommand.indexOf(" in ") + 4, inputCommand.length);
					errorOutput = itemName;
					break;
				}
			}
			
			errorOutput = "You can't put the " + itemName + " in that.";
			
			if (itemName == "" || targetName == "")
			{
				errorOutput = "What do you want to put the " + inputCommand.substring(command[0].length + 1, inputCommand.length) + " into?";
			}
			else
			{
				var objectExists:String = roomHandler.gettableHandler.checkItemExists(itemName, InventoryHolder); // Check if there is an item of the same input command in the inventory
				if (objectExists != null)
				{
					var targetExists:String = roomHandler.gettableHandler.checkItemExists(targetName, roomHandler.room);  // Check if the target we're trying to put the item to is in the same room
					if (targetExists != null)
					{
						var gettableObj:Class = getDefinitionByName(targetExists) as Class;    // Check if the target we're trying to put the item to is a container
						var child:* = new gettableObj;
						if (child is Container)
						{
							roomHandler.gettableHandler.moveGettable(objectExists, targetExists);
							outputHandler("You put a " + Utils.getObjectShortDesc(objectExists) + " in a " + Utils.getObjectShortDesc(targetExists) + "."); 
							this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
							return;
						}						
					}
				}
				else
				{
					errorOutput = "There's no " + itemName + " to put anywhere."
				}
			}
			
			outputHandler(errorOutput);
		}
		
// Look (at the room or at objects)		
		private function checkLookCommand(command:Array):void
		{
			if (command.length == 1) // If not looking at an object, just return room description
			{
				var longStr:String = roomHandler.getDescription();
				outputHandler(longStr);  // Special signal that does not added HTML tags (since room already adds HTML tags)
				return;
			}
			
			var newCommand:String = inputCommand.substr(command[0].length+1, inputCommand.length);
			if (command[1] == "at")   // Accomodate for 'look <object>' and 'look at <object>'
				newCommand = newCommand.substr(command[1].length + 1, newCommand.length);
			
			if (checkInventory(newCommand)) 
				return; 
			if (checkForNpcs(newCommand))  // If the player is looking at NPCs, will return true. Halt this conditional
				return;
			if (checkForGettables(newCommand))  // Same deal as above, but with gettable items
				return; 
			if (checkForRoomItems(newCommand)) 
				return; 
				
			if (newCommand == 'me' || newCommand == 'self' || newCommand == roomHandler.user.userName.toLowerCase())
				outputHandler(sheet.getSheet());
			else
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
			if (newCommand == "n") newCommand = "north";
			else if (newCommand == "s") newCommand = "south";
			else if (newCommand == "e") newCommand = "east";
			else if (newCommand == "w") newCommand = "west";
			else if (newCommand == "ne") newCommand = "northeast";
			else if (newCommand == "se") newCommand = "southeast";
			else if (newCommand == "sw") newCommand = "southwest";
			else if (newCommand == "nw") newCommand = "northwest";
			else if (newCommand == "u") newCommand = "up";
			else if (newCommand == "d") newCommand = "down";
			
			var obj:* = roomHandler.exits; // Check if the command matches the exits of the room.
			for (var i:* in obj) 
			{
				if (newCommand == i)
				{
					var longStr:String = "You leave out the " + newCommand + " exit."; // Then fetch the new description
					var className:String = getQualifiedClassName(obj[i]);
					var mainClass:Class = getDefinitionByName(className) as Class; // Change the room to the one matching the exit
					roomHandler.moveUserToRoom(new mainClass as Room);
					
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
				
				var action:Boolean = actionHandler(child.actions);
				if (action)
					return true;
			}
			return false;
		}
		
		private function checkRoomActions():Boolean
		{
			return actionHandler(roomHandler.actions);
		}
		
		private function checkNpcActions():Boolean 
		{
			for (var i:* in roomHandler.npcsThisRoom) // If there is an NPC in the room
			{
				var action:Boolean = actionHandler(roomHandler.npcsThisRoom[i].actions);
				if (action)
					return true;
			}
			return false;
		}
		
		private function actionHandler(actionObjects:Array):Boolean 
		{
			for (var j:* in actionObjects)
			{
				var keywords:* = actionObjects[j].keywords;
				var inputList:Array = inputCommand.split(' ');
				var matchedKeywords:int = 0;
				
				for (var c:* in keywords)   // The keywords are stored in arrays. The input string must contain a keyword from each array to pass
				{
					for (var inp:String in inputList)
					{
						if (keywords[c].indexOf(inputList[inp].toLowerCase()) > -1) 
						{
							matchedKeywords++;
							break;
						}
					}
				}
				
				if (matchedKeywords == keywords.length)
				{
					roomHandler.getResponse(actionObjects[j]);
					return true;
				}
			}
			return false;
		}
		
		private function checkConversations(command:Array):void
		{
			if (command.length == 1)
			{
				outputHandler("Talking to yourself again?");
				return;
			}
			
			var newCommand:String = inputCommand.substr(command[0].length+1, inputCommand.length);
			if (command[1] == "to")   // Accomodate for 'look <object>' and 'look at <object>'
				newCommand = newCommand.substr(command[1].length + 1, newCommand.length);			
			
			var objectExists:String = roomHandler.personHandler.checkNPCExists(newCommand, roomHandler.room);
			if (objectExists != null)
			{
				var convoOptions:Array = roomHandler.personHandler.getNPCConversation(objectExists);
				if (convoOptions == null || convoOptions.length == 0)
				{
					outputHandler(Utils.capitalize(Utils.getObjectShortDesc(objectExists)) + " has nothing to say to you.");
					return;
				}
				
				var randomId:int = Utils.generateRandom(0, convoOptions.length);
				var randomConvo:String = convoOptions[randomId];
				
				outputHandler(Utils.capitalize(Utils.getObjectShortDesc(objectExists)) + " says: '" + randomConvo);
				return;
			}
			else
			{
				outputHandler("You don't see any " + newCommand + " to talk to.");
				return;
			}
		}
		
		private function checkColours(commands:Array):void
		{
			switch (commands[0])
			{
				case "colours":
					if (isWhiteText)
						setTextBlack();
					else
						setTextWhite();
					break;
				case "black":
					setTextBlack();
					break;
				case "white":
					setTextWhite();
					break;
				default:
					break;
			}
		}
		
		private function setTextWhite():void
		{
			isWhiteText = true;
			outputHandler('Switching to white text, black background.');
			this.dispatchEvent(new ParserEvent('white', ParserEvent.COLOUR));
		}
		
		private function setTextBlack():void
		{
			isWhiteText = false;
			outputHandler('Switching to black text, white background.');
			this.dispatchEvent(new ParserEvent('black', ParserEvent.COLOUR));
		}
		
		private function incrementExperience(e:ParserEvent):void
		{
			sheet.incrementExperience(e.value);
			roomHandler.user = sheet.user;
		}
		
		private function lookHandler(e:OutputEvent):void
		{
			parseCommand("look");
		}
	}
	
}