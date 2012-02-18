package objects.house 
{
	import objects.Room;

	public class BedRoom extends Room;
	{
		public var shortDesc:String = "You are standing in a bedroom";
		public var longDesc:String = "You are standing in a bedroom. There is a neatly made bed with a bedside table here. \n"+
		"You can exit through the door to the north.";

		public function BedRoom() 
		{
		}
		
		
	}


}