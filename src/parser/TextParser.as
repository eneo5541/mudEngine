package parser 
{
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import handler.RoomHandler;
	import objects.house.BedRoom;
	
	public class TextParser extends EventDispatcher
	{
		private var roomHandler:RoomHandler;
		
		
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
			var output:String;
			
			switch (splitSpaces[0])
			{
				case "look":case "l":
					output = "You look around";
					var str:String = roomHandler.longDesc + "\n";
					output = str;
					//this.dispatchEvent(new LookEvent(LookEvent.LOOK));
					break;
				case "north":case "south":case "east":case "west":
					output = "You leave out the " + splitSpaces[0] + " exit";
					break;
				case "search":case "sear":
					output = "You search around";
					break;
				case "use":
					output = "You use an item";
					break;
				default:
					output = "I don't know how to " + splitSpaces[0];
					break;
			}
			
			return output + "\n";
		}
	}
	
}