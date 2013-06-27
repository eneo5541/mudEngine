package objects.rooms.house 
{
	import objects.gettables.house.Herbs;
	import objects.Room;

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
			exits["in"] = Kitchen;
		}
		
		override public function setGettables():void
		{
			gettables = [ Herbs ];
		}
		
		override public function setItems():void
		{
			items["balcony"] = "A wooden balcony.";
			items["trees"] = "Huge trees stretch into the sky and blot out the sunlight.";
			items["bushes"] = "Thick bushes of white flowers.";
			items["flowers"] = "These large, white flowers are very striking.";
			items["sunlight"] = "Thin rays of light pour in through the tree coverage overhead.";
			items["birds"] = "You can't see them, but they are making a lot of noise..";
			items["insects"] = "You can't see them, but they are making a lot of noise.";
			items["door"] = "The door leads back inside.";
		}
		
	}


}