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
			exits = { east:JunctionRoom };
		}
		
		override public function setItems():void
		{
			items = { 
				marble:"The marble construction of the room seems very solid. You take care not to slip on polished surface.",
				bathroom:"It contains the basic amenities, hewn from marble.",
				door:"The marble door must be for show, as it is far too heavy to close.",
				wall:"Soft grey lines criss-cross the white marble of the walls."
			};
		}
		
		override public function setAction():void
		{
			action = { 
				action:"close door", 
				response:function(target:*):String {
							return "You strain against the door, but it is far too heavy to move.";
						}
			};
		}
		
		override public function setGettables():void
		{
			gettables = ["objects.gettables.Towel"];
		}
	}


}