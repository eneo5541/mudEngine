package objects.rooms 
{
	import objects.Room;

	public class CorridorRoom extends Room
	{		
		public function CorridorRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Corridor.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in a corridor. It stretches endlessly to the east and west, where the light disappears into a stygian darkness. "+
			"There is a door behind you to the south.";
		}
		
		override public function setExits():void
		{
			exits = { 
				south:"objects.rooms.BedRoom",
				east:"objects.rooms.DeadEndRoom",
				west:"objects.rooms.Corridor2Room"
			};
		}
		
		override public function setNpcs():void
		{
			npcs = ["objects.npcs.Butler"];
		}
		
	}


}