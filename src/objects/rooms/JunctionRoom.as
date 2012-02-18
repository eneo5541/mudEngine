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
			shortDesc = "A junction.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are at a crossroads in the corridor. Another corridor lies behind you to the south, " +
			"while a marbled room lies to the west. To the north is a flight of stairs leading upwards, while you can " +
			"hear the sound of the wind to your east. ";
		}
		
		override public function setExits():void
		{
			exits = { 
				south:"objects.rooms.Corridor2Room",
				west:"objects.rooms.BathRoom",
				east:"objects.rooms.OutdoorsRoom",
				north:"objects.rooms.StairsRoom"
			};
		}
	}


}