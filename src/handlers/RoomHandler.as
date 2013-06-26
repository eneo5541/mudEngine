package handlers 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import handlers.holders.InventoryHolder;
	import objects.Room;
	import objects.User;
	import parser.Utils;
	import signals.OutputEvent;
	import signals.ParserEvent;

	public class RoomHandler extends Sprite
	{
		public var gettableHandler:GettableHandler;
		public var personHandler:PersonHandler;
		
		public var room:String;
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var actions:*;
		public var npcsThisRoom:Array;
		public var user:User;
		
		public var dialogueTimer:Timer;
		
		function RoomHandler()
		{
			gettableHandler = new GettableHandler();
			addChild(gettableHandler);
			
			personHandler = new PersonHandler();
			addChild(personHandler);
			
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
					var randomDialogue:int = Utils.generateRandom(0, (randomNpc.dialogue.length * 2)); // This makes sure that dialogue will not always be displayed
					if(randomDialogue < randomNpc.dialogue.length)        // Send the dialogue up to the text parser, which will output it to screen
						this.dispatchEvent(new OutputEvent(randomNpc.dialogue[randomDialogue], OutputEvent.OUTPUT));
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
			this.actions = room.actions
			
			dialogueTimer.start();
			
			getDescription();
		}
		
		private function loadNpcs(target:*):void
		{
			var npcObject:* = target;
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
		
		private function addExits():String  // Converts all of the anonymous objects into an array	
		{	
			if (this.exits == null) 
				return "\nThere are no obvious exits.";	
			
			var obj:* = this.exits;
			var objectList:Array = [];
			for (var i:* in obj) 
				objectList.push(i);
			
			var listedExits:String = Utils.listExits(objectList);
			return listedExits;
		}
		
		private function addNpcs():String
		{
			npcsThisRoom = personHandler.personsThisRoom(room);
			
			var toString:Array = [];
			for (var i:* in npcsThisRoom)
				toString.push(npcsThisRoom[i].shortDesc);
			
			var listedNPCs:String = Utils.listNpcs(toString);
			return listedNPCs;
		}
		
		private function addGettables():String
		{
			var allGettables:Array = gettableHandler.gettablesThisRoom(room);
			var listedGettables:String = Utils.listGettables(allGettables);
			return listedGettables;
		}
		
		public function getResponse(action:*):void
		{
			if (action.required != null)
			{
				if (!checkParametersMet(action.required)) { // If the parameter is NOT met, do not continue
					outputText(action.required.error);
					return;
				}
			}
			if (action.excluded != null)
			{
				if (checkAlreadyStarted(action.excluded)) {  // If the parameter IS met, than the quest has already been started - do not continue
					outputText(action.excluded.error);
					return;
				}
			}
			var f:Function = action.response;
			f(this);  // The 'this' parameter allows the response function to be called from the roomHandler, instead of the room
		}
		
		private function checkAlreadyStarted(required:*):Boolean // This allows the action to proceed if the item/npc DOES NOT exist
		{
			var parameterType:String = "";
			var parameterObj:String = "";
			for (var i:* in required) 
			{
				if(i != "error") {    // Do not pick up error parameter, only targetted parameter
					parameterType = i;
					parameterObj = getQualifiedClassName(required[i]);
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
		
		private function checkParametersMet(required:*):Boolean // This allows the action to proceed ONLY if the item/npc DOES exist
		{
			var parameterType:String = "";
			var parameterObj:String = "";
			for (var i:* in required) 
			{
				if(i != "error") {    // Do not pick up error parameter, only targetted parameter
					parameterType = i;
					if (getQualifiedClassName(required[i]) == 'int')
						parameterObj = required[i] + "";
					else
						parameterObj = getQualifiedClassName(required[i]);
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
				case "level":
					if (user.level >= parseInt(parameterObj))
						return true;
					break;
				default:
					break;
			}
			
			return false;
		}

// Commands the object actions can call to affect the game world
		public function addExperience(quantity:int):void
		{			
			this.dispatchEvent(new OutputEvent("\nYou have gained "+ quantity + " experience.", OutputEvent.OUTPUT));
			this.dispatchEvent(new ParserEvent(quantity, ParserEvent.SHEET));
		}
		
		public function moveUserToRoom(room:Room):void
		{	
			loadRoom(room);
			lookAtRoom();
		}
		
		public function lookAtRoom():void
		{	
			dialogueTimer.stop(); 
			this.dispatchEvent(new OutputEvent(null, OutputEvent.LOOK));
		}
		
		public function reloadRoom():void
		{	
			var thisRoom:Class = getDefinitionByName(this.room) as Class; // Change the room to the one matching the exit
			loadRoom(new thisRoom as Room);
			dialogueTimer.stop(); 
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
			
			this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
		}
		
		public function removeGettable(object:*):void
		{
			gettableHandler.removeGettable(object);
			
			this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
		}
		
		public function moveGettable(object:*, location:*):void
		{
			gettableHandler.addGettable(object, location);
			gettableHandler.moveGettable(object, location);
			
			this.dispatchEvent(new ParserEvent(null, ParserEvent.INVENTORY));
		}
		
		public function outputText(newText:String):void
		{
			this.dispatchEvent(new OutputEvent(newText, OutputEvent.OUTPUT));
		}	
	}

	
}