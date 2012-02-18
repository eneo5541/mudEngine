package objects.rooms 
{
	import objects.Room;

	public class BathRoom extends Room
	{		
		public function BathRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A bathroom";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "This is a plain, functional bathroom. Everything here is made of polished white marble and " +
			"looks remarkably clean. There is a marbled door leading out, on the eastern wall.";
		}
		
		override public function setExits():void
		{
			exits = { east:"objects.rooms.JunctionRoom" };
		}
	}


}