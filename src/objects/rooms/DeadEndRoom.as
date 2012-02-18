package objects.rooms 
{
	import objects.Room;

	public class DeadEndRoom extends Room
	{		
		public function DeadEndRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Dead-end.";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "The corridor extends into infinity, and there is only blackness, and nothing more. " +
			"You can return back up the corridor to the west";
		}
		
		override public function setExits():void
		{
			exits = { west:"objects.rooms.CorridorRoom" };
		}
	}


}