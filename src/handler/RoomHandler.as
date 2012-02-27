package handler 
{
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import objects.Gettable;
	import objects.Person;
	import objects.Room;
	import parser.DialogueEvent;
	import parser.OutputEvent;
	import parser.RandomRange;

	public class RoomHandler extends EventDispatcher
	{
		private var listHandler:ListHandler = new ListHandler();
		public var gettableHandler:GettableHandler = new GettableHandler();
		public var personHandler:PersonHandler = new PersonHandler();
		
		public var room:String;
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var action:*;
		public var npcsThisRoom:Array;
		
		private var dialogueTimer:Timer;
		
		function RoomHandler()
		{
			dialogueTimer = new Timer(3500);
			dialogueTimer.addEventListener(TimerEvent.TIMER, getDialogue);
			dialogueTimer.start();
		}
		
		private function getDialogue(event:TimerEvent):void
		{
			if (npcsThisRoom.length > 0)  // If there are NPCs in the room
			{
				var randomId:int = RandomRange.generate(0, npcsThisRoom.length);  // Randomly select one NPC
				var randomNpc:* = npcsThisRoom[randomId];
				if (randomNpc.dialogue != null)  // Check if the NPC has dialogue
				{ 
					var randomDialogue:int = RandomRange.generate(0, (randomNpc.dialogue.length * 2)); // This makes sure that dialogue will not always be displayed
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
			this.action = room.action
			
			dialogueTimer.start();
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
			var required:String = "<p class='title'>" + shortDesc + "</p><p>\n" + longDesc + "</p><p class='exits'>" + addExits() + "</p>";
			var npcString:String = addNpcs();
			var gettableString:String = addGettables(); 
			
			if (npcString.length > 0)    // Only add when npc and gettable arrays are not empty
				required += "<p>" + npcString + "</p>"
			if (gettableString.length > 0)
				required += "<p>" + gettableString + "</p>";
			
			return required;
		}
		
		private function addExits():String
		{	
			if (this.exits == null) return ""; // Converts all of the anonymous objects into an array		
			
			var obj:* = this.exits;
			var objectList:Array = [];
			for (var i:* in obj) 
				objectList.push(i);
			
			var tr:String = listHandler.listExits(objectList);
			return tr;
		}
		
		private function addNpcs():String
		{
			npcsThisRoom = personHandler.personsThisRoom(room);
			
			var toString:Array = [];
			for (var i:* in npcsThisRoom)
				toString.push(npcsThisRoom[i].shortDesc);	
			var tr:String = listHandler.listNpcs(toString);
			
			return tr;
		}
		
		private function addGettables():String
		{
			var td:Array = gettableHandler.gettablesThisRoom(room);
			var tr:String = listHandler.listGettables(td);
			return tr;
		}
		
		public function getResponse(action:*):String
		{
			if (action.parameter != null)
			{
				if (!checkParametersMet(action.parameter))  // If the parameters are not met, do not continue
					return action.parameter.error;
			}
			var f:Function = action.response;
			return f(this); // The 'this' parameter allows the response function to be called from the roomHandler, instead of the room
		}
		
		
		private function checkParametersMet(parameter:*):Boolean 
		{
			var parameterType:String = "";
			var parameterObj:String = "";
			for (var i:* in parameter) 
			{
				parameterType = i;
				parameterObj = getQualifiedClassName(parameter[i]);
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
					var inventory:Array = gettableHandler.checkGettableLocation(new InventoryHandler);
					
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
		
		

		
		
		
	}

	
}