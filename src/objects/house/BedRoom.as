package objects.house 
{
	import objects.Room;

	public class BedRoom extends Room
	{		
		public function BedRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Bedroom.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in a bedroom. There is a neatly made bed with a bedside table here. "+
			"A plain wooden door is built into the north wall.";
			addExits();
		}
		
		override public function setExits():void
		{
			exits = { north:"objects.house.CorridorRoom" };
		}
		
	}


}