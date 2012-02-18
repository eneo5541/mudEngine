package objects.rooms 
{
	import objects.Room;

	public class Corridor2Room extends Room
	{		
		public function Corridor2Room() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Corridor.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A plain, lonely door sits on the northern wall, while the corridor continues infinitely to the " +
			"east and west. ";
		}
		
		override public function setExits():void
		{
			exits = { 
				east:"objects.rooms.CorridorRoom", 
				north:"objects.rooms.JunctionRoom"
			};
		}
	}


}