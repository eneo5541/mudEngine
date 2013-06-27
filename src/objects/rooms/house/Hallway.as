package objects.rooms.house 
{
	import objects.Room;

	public class Hallway extends Room
	{	
		public function Hallway() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Hallway</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A simple hallway. There is a bedroom to the east, a bathroom to the south and a livingroom to the west.";
		}
		
		override public function setExits():void
		{
			exits["east"] = Bedroom;
			exits["south"] = Bathroom;
			exits["west"] = Livingroom;
		}
		
		override public function setItems():void
		{
			items["bedroom"] = "A cosy looking bedroom",
			items["bathroom"] = "The bathroom looks very clean.",
			items["livingroom"] = "A nice livingroom with plush furniture."
		}
		
	}


}