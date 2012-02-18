package handler 
{
	import objects.house.BedRoom;
	import objects.Room;
	public class RoomHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		
		function RoomHandler()
		{
		}
		 
		public function loadRoom(room:Room):void
		{
			this.longDesc = room.longDesc;
			this.shortDesc = room.shortDesc;
			this.exits = room.exits;
		}
	}
	
}