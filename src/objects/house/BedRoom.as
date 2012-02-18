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
			shortDesc = "You are standing in a bedroom";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in a bedroom. There is a neatly made bed with a bedside table here. \n"+
			"You can exit through the door to the north.";
		}
		
	}


}