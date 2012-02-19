package objects.rooms 
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
		}
		
		override public function setExits():void
		{
			exits = { north:"objects.rooms.CorridorRoom" };
		}
		
		override public function setItems():void
		{
			items = { 
				bed:"A neatly made bed with taupe sheets and a pillow.",
				table:"A small, lacquered wood table sits next to the bed.",
				door:"A white, wooden door. It must lead outside.",
				wall:"The walls are a soft peach colour."
			};
		}
		
		override public function setGettables():void
		{
			gettables = ["objects.gettables.Watch"];
		}
		
		override public function setAction():void
		{
			action = { 
				action:"search table", 
				response:function(target:*):String {
							target.gettableHandler.addGettable("objects.gettables.Knife", new BedRoom);
							return "You search the table and find a pen knife.";
						}
			};
		}
		
	}


}