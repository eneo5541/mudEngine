package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import handler.GettableHandler;
	import handler.PersonHandler;
	import handler.RoomHandler;
	import objects.Gettable;
	import objects.gettables.Binoculars;
	import objects.gettables.Towel;
	import objects.gettables.Watch;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.Person;
	import objects.Room;
	import objects.rooms.BathRoom;
	import objects.rooms.BedRoom;
	import objects.rooms.Corridor2Room;
	import objects.rooms.CorridorRoom;
	import objects.rooms.DeadEndRoom;
	import objects.rooms.JunctionRoom;
	import objects.rooms.OutdoorsRoom;
	import objects.rooms.StairsRoom;
	
	public class TextParser extends EventDispatcher
	{
		private var inputCommand:String;
		public var roomHandler:RoomHandler;
		private var personHandler:PersonHandler;
		private var gettableHandler:GettableHandler;
		// Need to find out how to get getDefinitionByName to work without creating these
		private var _bathroom:BathRoom;
		private var _bedRoom:BedRoom;
		private var _corridorRoom:CorridorRoom;
		private var _corridor2Room:Corridor2Room;
		private var _deadEndRoom:DeadEndRoom;
		private var _junctionRoom:JunctionRoom;
		private var _outdoorsRoom:OutdoorsRoom;
		private var _stairsRoom:StairsRoom;
		private var _butler:Butler;
		private var _dog:Dog;
		private var _watch:Watch;
		private var _towel:Towel;
		private var _binoculars:Binoculars;
		
		
		function TextParser()
		{
			roomHandler = new RoomHandler;
			roomHandler.loadRoom(new BedRoom);
			
			personHandler = new PersonHandler;
			gettableHandler = new GettableHandler;
		}
		 
		public function parseCommand(command:String):void
		{
			inputCommand = command;
			if (command == null || command.length == 0)
			{
				this.dispatchEvent(new OutputEvent("", OutputEvent.OUTPUT));
				return;
			}
			var splitSpaces:Array = command.split(" ");
			
			if (splitSpaces[0] == "look" || splitSpaces[0] == "l")
			{
				checkLookCommand(splitSpaces);
			}
			else if (splitSpaces[0] == "go" || splitSpaces[0] == "g")
			{
				checkDirectionCommand(splitSpaces);
			}
			else
			{
				checkDynamicCommands(splitSpaces);
			}
			
		}
		
		
		private function checkLookCommand(command:Array):void
		{
			if (command.length == 1) // If not looking at an object, just return room description
			{
					var longStr:String = roomHandler.getDescription();
					this.dispatchEvent(new OutputEvent(longStr, OutputEvent.OUTPUT));
					return;
			}
				
			if (checkForObjects(roomHandler.npcs, command[1])) return;   // If the player is looking at NPCs, will return true. Halt this conditional
			
			if (checkForObjects(roomHandler.gettables, command[1])) return;  // Same deal as above with gettable items

			var itemObject:* = roomHandler.items; // Check if the second word matches the room's items 
			for (var i:* in itemObject) 
			{
				if (command[1] == i) 
				{
					this.dispatchEvent(new OutputEvent(itemObject[i] + "\n", OutputEvent.OUTPUT));
					return;
				}
			}
			
			this.dispatchEvent(new OutputEvent("I don't see any " + command[1] + ".\n", OutputEvent.OUTPUT));
			return;
		}
		
		
		private function checkForObjects(target:*, command:String):Boolean
		{
			var npcObject:* = target;
			for (var i:* in npcObject) // Iterate through all the objects in the room (either items or npcs)
			{
				var child:*= npcObject[i];
				for (var j:* in child.alias)  // Then iterate all the aliases for that object
				{
					if (command == child.alias[j])  // If matching, return description
					{
						this.dispatchEvent(new OutputEvent(child.longDesc + "\n", OutputEvent.OUTPUT));
						return true;
					}
				}
			}
			
			return false;
		}
		
		
		private function checkDirectionCommand(command:Array):void
		{
			var obj:* = roomHandler.exits; // Check if the command matches the exits of the room.
			for (var i:* in obj) 
			{
				if (command[1] == i)
				{
					var mainClass:Class = getDefinitionByName(obj[i]) as Class; // Change the room to the one matching the exit
					roomHandler.loadRoom(new mainClass as Room);
					
					var longStr:String = "You leave out the " + command[1] + " exit. \n" + roomHandler.getDescription(); // Then fetch the new description
					this.dispatchEvent(new OutputEvent(longStr, OutputEvent.OUTPUT));
					return;
				}
			}
			
			this.dispatchEvent(new OutputEvent("I don't see any " + command[1] + " exit.\n", OutputEvent.OUTPUT));
			return;
		}
		
		
		private function checkDynamicCommands(command:Array):void
		{
			var errorMsg:String = "I don't know how to " + inputCommand + ".\n";
			this.dispatchEvent(new OutputEvent(errorMsg, OutputEvent.OUTPUT));
		}
		
	}
	
}