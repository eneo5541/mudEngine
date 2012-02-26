package objects.rooms 
{
	import objects.Room;

	public class JunctionRoom extends Room
	{		
		public function JunctionRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A junction";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are at a crossroads in the corridor. Another corridor lies behind you to the south, " +
			"while a marbled room lies to the west. To the north is a flight of stairs leading upwards, while you can " +
			"hear the sound of the wind to your east. There is a hat rack and rug by the eastern door.";
		}
		
		override public function setItems():void
		{
			items = { 
				corridor:"The same orange corridors that fill the rest of the house",
				room:"The marble in that room is polished to a mirror finish. Its hard to make out anything from here.",
				stairs:"The stairs lead upstairs.",
				wind:"You can't see the wind.",
				rack:"The hat-rack is empty. You wish you had a hat to put on it though.",
				rug:"The rug reads 'Welcome to our Home'"
			};
		}
		
		override public function setExits():void
		{
			exits = { 
				south:Corridor2Room,
				west:BathRoom,
				east:OutdoorsRoom,
				north:StairsRoom
			};
		}
	}


}