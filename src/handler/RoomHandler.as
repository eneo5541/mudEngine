package handler 
{
	import objects.Room;

	public class RoomHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var npcs:*;
		
		function RoomHandler()
		{
		}
		 
		public function loadRoom(room:Room):void
		{
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			this.npcs = room.npcs;
		}
	}
	
}