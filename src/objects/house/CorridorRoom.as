package objects.house 
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
			shortDesc = "You are standing in a corridor.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in a corridor. It stretches endlessly to the east and west. \n"+
			"There is a door behind you to the south";
		}
				
		override public function setExits():void
		{
			exits = { south:"objects.house.BedRoom" };
		}
	}


}