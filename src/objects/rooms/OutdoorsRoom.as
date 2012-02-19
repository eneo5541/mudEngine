package objects.rooms 
{
	import objects.Room;

	public class OutdoorsRoom extends Room
	{		
		public function OutdoorsRoom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A field";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in an open field west of a white house, with a boarded front door. "+
			"There is a small mailbox here.";
		}
		
		override public function setExits():void
		{
			exits = { west:"objects.rooms.JunctionRoom" };
		}
		
		override public function setItems():void
		{
			items = { 
				house:"The house is a beautiful colonial house which is painted white. It is clear that the owners " +
				"must have been extremely wealthy.",
				door:"The door is closed.",
				mailbox:"The small mailbox is closed."
			};
		}
		
		override public function setNpcs():void
		{
			npcs = ["objects.npcs.Dog"];
		}
	}


}