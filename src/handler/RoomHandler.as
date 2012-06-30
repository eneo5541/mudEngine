package handler 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	
	import objects.Gettable;
	import objects.Person;
	import objects.Room;
	
	import signals.DialogueEvent;
	import signals.OutputEvent;
	import parser.Utils;

	public class RoomHandler extends EventDispatcher
	{
		public var gettableHandler:GettableHandler = new GettableHandler();
		public var personHandler:PersonHandler = new PersonHandler();
		
		public var room:String;
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var actions:*;
		public var npcsThisRoom:Array;
		
		public var dialogueTimer:Timer;
		
		function RoomHandler()
		{
			gettableHandler.addEventListener(DialogueEvent.OUTPUT, gettableDialogue);
			
			dialogueTimer = new Timer(20000);
			dialogueTimer.addEventListener(TimerEvent.TIMER, getDialogue);
			dialogueTimer.start();
		}
		
		private function getDialogue(event:TimerEvent):void
		{
			if (npcsThisRoom.length > 0)  // If there are NPCs in the room
			{
				var randomId:int = Utils.generateRandom(0, npcsThisRoom.length);  // Randomly select one NPC
				var randomNpc:* = npcsThisRoom[randomId];
				if (randomNpc.dialogue != null)  // Check if the NPC has dialogue
				{ 
					var randomDialogue:int = Utils.generateRandom(0, (randomNpc.dialogue.length * 3)); // This makes sure that dialogue will not always be displayed
					if(randomDialogue < randomNpc.dialogue.length)        // Send the dialogue up to the text parser, which will output it to screen
						this.dispatchEvent(new DialogueEvent(randomNpc.dialogue[randomDialogue], DialogueEvent.OUTPUT)); 
				}
			}
		}
		
		public function loadRoom(room:Room):void
		{	
			dialogueTimer.stop();
			
			this.room = getQualifiedClassName(room);
			
			loadNpcs(room.npcs);
			loadGettables(room.gettables);
			
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			this.actions = room.actions;
			
			dialogueTimer.start();
		}
		
		private function loadNpcs(target:*):void
		{
			var npcObject:* = target; // Same as loadGettables()
			for (var i:* in npcObject)
				personHandler.addPerson(npcObject[i], room);
		}
		
		private function loadGettables(target:*):void
		{									
			var gettableObject:* = target; // On loadRoom, add that room's objects to the gettableHandler
			for (var i:* in gettableObject)// The handler stores each object, so that it can be manipulated independently of the room				   
				gettableHandler.addGettable(gettableObject[i], room);
		}
		
		public function getDescription():String 
		{
			var required:String = shortDesc + "\n" + longDesc + "\n<span class='cyan'>" + addExits() + "</span>";
			var npcString:String = addNpcs();
			var gettableString:String = addGettables(); 
			
			if (npcString.length > 0)    // Only add when npc and gettable arrays are not empty
				required += '\n' + npcString;
			if (gettableString.length > 0)
				required += '\n' + gettableString;
			
			return required;
		}
		
		private function addExits():String // Converts all of the anonymous objects into an array	
		{	
			if (this.exits == null) 
				return "\nThere are no obvious exits.";
			
			var obj:* = this.exits;
			var objectList:Array = [];
			for (var i:* in obj) 
				objectList.push(i);
			
			var exitList:String = Utils.listExits(objectList);
			return exitList;
		}
		
		private function addNpcs():String
		{
			npcsThisRoom = personHandler.personsThisRoom(room);
			
			var toString:Array = [];
			for (var i:* in npcsThisRoom)
				toString.push(npcsThisRoom[i].shortDesc);	
			var npcList:String = Utils.listNpcs(toString);
			
			return npcList;
		}
		
		private function addGettables():String
		{
			var itemList:Array = gettableHandler.gettablesThisRoom(room);
			var itemString:String = Utils.listGettables(itemList);
			return itemString;
		}
		
		public function getResponse(action:*):void
		{
			if (action.parameter != null)
			{
				if (!checkParametersMet(action.parameter)) { // If the parameter is NOT met, do not continue
					outputText(action.parameter.error);
					return;
				}
			}
			if (action.restart != null)
			{
				if (checkAlreadyStarted(action.restart)) {  // If the parameter IS met, then the quest has already been started - do not continue
					outputText(action.restart.error);
					return;
				}
			}
			var f:Function = action.response;
			f(this);  // The 'this' parameter allows the response function to call variables belonging to the roomHandler
		}
		
		private function checkAlreadyStarted(parameter:*):Boolean // This allows the action to proceed if the item/npc DOES NOT exist
		{
			var parameterType:String = "";
			var parameterObj:String = "";
			for (var i:* in parameter) 
			{
				if(i != "error") {    // Do not pick up error parameter, only targetted parameter
					parameterType = i;
					parameterObj = getQualifiedClassName(parameter[i]);
				}
			}
			
			switch (parameterType)
			{
				case "npc":  // check if an NPC or gettable exists
					if (personHandler.searchPersons(parameterObj))
						return true;
					break;
				case "room":
					if (parameterObj == room)
						return true;
					break;
				case "gettable":
					if (gettableHandler.searchGettables(parameterObj))
						return true;
					break;
				default:
					break;
			}
			
			return false;
		}
		
		private function checkParametersMet(parameter:*):Boolean // This allows the action to proceed ONLY if the item/npc DOES exist
		{
			var parameterType:String = "";
			var parameterObj:String = "";
			for (var i:* in parameter) 
			{
				if(i != "error") {    // Do not pick up error parameter, only targetted parameter
					parameterType = i;
					if (getQualifiedClassName(parameter[i]) == 'int')
						parameterObj = parameter[i] + "";
					else
						parameterObj = getQualifiedClassName(parameter[i]);
				}
			}
			
			switch (parameterType)
			{
				case "npc":
					for (var j:* in npcsThisRoom)
					{
						if (parameterObj == getQualifiedClassName(npcsThisRoom[j]))  // If the parameter npc is currently in the room
							return true;
					}
					break;
				case "room":
					if (parameterObj == room)   // If the current room is the parameter room
						return true;
					break;
				case "gettable":
					var inventory:Array = gettableHandler.checkGettableLocation(InventoryHolder);
					
					for (var k:* in inventory)
					{
						if (parameterObj == inventory[k])
							return true;
					}
					break;
				default:
					break;
			}
			
			return false;
		}
		
		public function addPerson(object:*, location:*):void
		{
			personHandler.addPerson(object, location);
		}
		
		public function removePerson(object:*):void
		{
			personHandler.removePerson(object);
		}
		
		public function movePerson(object:*, location:*):void
		{
			personHandler.addPerson(object, location);
			personHandler.movePerson(object, location);
		}
		
		public function addGettable(object:*, location:*):void
		{
			gettableHandler.addGettable(object, location);
		}
		
		public function removeGettable(object:*):void
		{
			gettableHandler.removeGettable(object);
		}
		
		public function moveGettable(object:*, location:*):void
		{
			gettableHandler.addGettable(object, location);
			gettableHandler.moveGettable(object, location);
		}
		
		private function gettableDialogue(e:DialogueEvent):void
		{
			outputText(e.value);
		}
		
		public function outputText(newText:String):void
		{
			this.dispatchEvent(new DialogueEvent(newText, DialogueEvent.OUTPUT)); 
		}		
		
	}

	
}