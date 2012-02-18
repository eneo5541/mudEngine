package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import handler.PersonHandler;
	import handler.RoomHandler;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.Person;
	import objects.Room;
	import objects.house.BathRoom;
	import objects.house.BedRoom;
	import objects.house.Corridor2Room;
	import objects.house.CorridorRoom;
	import objects.house.DeadEndRoom;
	import objects.house.JunctionRoom;
	import objects.house.OutdoorsRoom;
	import objects.house.StairsRoom;
	
	public class TextParser extends EventDispatcher
	{
		private var roomHandler:RoomHandler;
		private var personHandler:PersonHandler;
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
		
		
		function TextParser()
		{
			roomHandler = new RoomHandler;
			roomHandler.loadRoom(new BedRoom);
			
			personHandler = new PersonHandler;;
		}
		 
		public function parseCommand(command:String):String
		{
			if (command == null || command.length == 0)
				return "\n";
			var splitSpaces:Array = command.split(" ");
			
			if (splitSpaces[0] == "look" || splitSpaces[0] == "l")
			{
				return checkLookCommand(splitSpaces);
			}
			else
			{
				return checkDynamicCommands(splitSpaces);
			}
			
			return "Error occurred, must not have caught " + splitSpaces[0] + ".\n";
		}
		
		
		function checkLookCommand(command:Array):String
		{
			if (command.length == 1) {// If not looking at an object, just return room description
					var longStr:String = roomHandler.longDesc;
					return longStr + "\n";
				}
				
				var npcObject:* = roomHandler.npcs;// Check if the second work after look matches any of the rooms items
				for (var i:* in npcObject) 
				{ // Need to make this non-case sensitive. By converting the name to all lower case? 
					if (command[1] == i) 
					{
						var mainClass:Class = getDefinitionByName(npcObject[i]) as Class;
						personHandler.loadPerson(new mainClass as Person);
						return personHandler.longDesc + "\n";
					}
				}
				
				var itemObject:* = roomHandler.items;// Check if the second work after look matches any of the rooms items
				for (var i:* in itemObject) 
				{
					if (command[1] == i) 
						return itemObject[i] + "\n";
				}
					
				return "I don't see any " + command[1] + ".\n";// If not found, user is trying to look at an item that does not exist.
		}
		
		function checkDynamicCommands(command:Array):String 
		{
			var obj:* = roomHandler.exits; // Check if the command matches the exits of the room. If so, change the current room to the class in the exit's value.
			for (var i:* in obj) 
			{
				if (command[0] == i)
				{
					var mainClass:Class = getDefinitionByName(obj[i]) as Class;
					roomHandler.loadRoom(new mainClass as Room);
					return "You leave out the " + command[0] + " exit. \n" + roomHandler.longDesc + "\n";
				}
			}
			
			return "I don't know how to " + command[0] + ".\n";// If the command is not an exit, its unknown
		}
		
	}
	
}