package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import handler.RoomHandler;
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
		// Need to find out how to get getDefinitionByName to work without creating these
		private var _bathroom:BathRoom;
		private var _bedRoom:BedRoom;
		private var _corridorRoom:CorridorRoom;
		private var _corridor2Room:Corridor2Room;
		private var _deadEndRoom:DeadEndRoom;
		private var _junctionRoom:JunctionRoom;
		private var _outdoorsRoom:OutdoorsRoom;
		private var _stairsRoom:StairsRoom;
		
		
		function TextParser()
		{
			roomHandler = new RoomHandler;
			roomHandler.loadRoom(new BedRoom);
		}
		 
		public function parseCommand(command:String):String
		{
			if (command == null || command.length == 0)
				return "\n";
			var splitSpaces:Array = command.split(" ");
			
			switch (splitSpaces[0])
			{
				case "look":case "l":
					var longStr:String = roomHandler.longDesc;
					return longStr + "\n";
					//this.dispatchEvent(new LookEvent(LookEvent.LOOK));
					break;
				case "glance":case "g":
					var shortStr:String = roomHandler.shortDesc;
					return shortStr + "\n";
					break;
				case "search":case "sear":
					return  "You search around. \n";
					break;
				case "use":
					return  "You use an item. \n";
					break;
				default:					
					var obj:* = roomHandler.exits;
					// Check if the command matches the exits of the room. If so, change the current room to the class in the exit's value.
					for (var i:* in obj) 
					{
						if (splitSpaces[0] == i) {
							var mainClass:Class = getDefinitionByName(obj[i]) as Class;
							roomHandler.loadRoom(new mainClass as Room);
							return "You leave out the " + splitSpaces[0] + " exit. \n" + roomHandler.longDesc + "\n";
					return longStr + "\n";;
						}
					}
					// If the command is not an exit, its unknown
					return "I don't know how to " + splitSpaces[0] + "\n";
					break;
			}
			return "Error occurred, invalid input of " + splitSpaces[0] + "\n";
		}
	}
	
}