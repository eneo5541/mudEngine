package parser 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import handler.RoomHandler;
	import objects.house.BedRoom;
	import objects.house.CorridorRoom;
	import objects.Room;
	
	public class TextParser extends EventDispatcher
	{
		private var roomHandler:RoomHandler;
		// Need to find out how to get getDefinitionByName to work without creating these
		private var _corridorRoom:CorridorRoom;
		private var _bedRoom:BedRoom;
		
		
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
					var str:String = roomHandler.longDesc;
					return str + "\n";
					//this.dispatchEvent(new LookEvent(LookEvent.LOOK));
					break;
				case "search":case "sear":
					return  "You search around. \n";
					break;
				case "use":
					return  "You use an item. \n";
					break;
				default:					
					var obj:* = roomHandler.exits;
					for (var i:* in obj) 
					{
						if (splitSpaces[0] == i) {
							var mainClass:Class = getDefinitionByName(obj[i]) as Class;
							roomHandler.loadRoom(new mainClass as Room);
							return "You leave out the " + splitSpaces[0] + " exit. \n";
						}
					}
					
					return "I don't know how to " + splitSpaces[0] + "\n";
					break;
			}
			return "Error occurred, invalid input of " + splitSpaces[0] + "\n";
		}
	}
	
}