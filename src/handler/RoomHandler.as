package handler 
{
	import objects.house.BedRoom;
	import objects.Room;
	public class RoomHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		
		function RoomHandler()
		{
		 
		}
		 
		public function loadRoom(room:Room):void
		{
			//var td = new BedRoom();
			this.longDesc = room.longDesc;
			this.shortDesc = room.shortDesc;
			trace(longDesc);
		}
	}
	
}