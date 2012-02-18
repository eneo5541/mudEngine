package objects.rooms 
{
	import objects.Room;

	public class StairsRoom extends Room
	{		
		public function StairsRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Balcony";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "The stairs led you to a balcony. You can see endless fields and mountains in all directions " +
			"and the sound of birds chirping fills your ears. You can return back down the stairs to the south.";
		}
		
		override public function setExits():void
		{
			exits = { south:"objects.rooms.JunctionRoom" };
		}
		
		override public function setGettables():void
		{
			gettables = { Binoculars:"objects.gettables.Binoculars" };
		}
	}


}