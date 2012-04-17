package objects.rooms.house 
{
	import objects.Room;
	import objects.gettables.house.Herbs;

	public class Outdoors extends Room
	{	
		public function Outdoors() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Outdoors</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are standing in a balcony, surrounded by trees and thick flower bushes. You can hear birds and insects in the air around you, and sunlight is pouring through gaps in the foliage " +
			"overhead. A door leads back inside.";
		}
		
		override public function setExits():void
		{
			exits = { inside:Kitchen };
		}
		
		override public function setGettables():void
		{
			gettables = [ Herbs ];
		}
		
		override public function setItems():void
		{
			items = {
				balcony:"A wooden balcony.",
				trees:"Huge trees stretch into the sky and blot out the sunlight.",
				bushes:"Thick bushes of white flowers.",
				flowers:"These large, white flowers are very striking.",
				sunlight:"Thin rays of light pour in through the tree coverage overhead.",
				birds:"You can't see them, but they are making a lot of noise.",
				insects:"You can't see them, but they are making a lot of noise.",
				door:"The door leads back inside."
			};
		}
		
	}


}