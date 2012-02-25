package objects.rooms 
{
	import objects.Room;

	public class OriginRoom extends Room
	{	
		public function OriginRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Origin.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A plain white room. This is the origin of all things. Once you leave, you will enter the world, and cannot return. ";
		}
		
		override public function setExits():void
		{
			exits = { out:BedRoom };
		}
		
	}


}