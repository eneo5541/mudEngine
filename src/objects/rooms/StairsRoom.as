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
			exits = { south:JunctionRoom };
		}
		
		override public function setItems():void
		{
			items = { 
				stairs:"A narrow stairway leads back down into the house.",
				balcony:"The balcony is a small platform protruding from the roof of the house. A shingled roof " +
				"protects you from the worse effects of the sun.",
				fields:"Rich green fields extend further than the eye can see.",
				mountains:"The mountains frame the horizons around you. You can see that snow caps the peaks of some of the taller ones.",
				birds:"You can't see any birds, but the air is filled with their music."
			};
		}
		
		override public function setGettables():void
		{
			gettables = ["objects.gettables.Binoculars"];
		}
	}


}