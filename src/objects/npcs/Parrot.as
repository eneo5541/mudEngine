package objects.npcs 
{
	import objects.Person;
	import objects.rooms.CorridorRoom;

	public class Parrot extends Person
	{		
		public function Parrot() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Parrot";
		}
		
		override public function setAlias():void
		{
			alias = ["Parrot", "parrot", "bird"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A brightly colour parrot. He is oddly quiet apart from a few odd chirps. \n" +
			"He is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The parrot caws loudly.",
				"The parrot chirps and cranes his head at you.",
			];
		}
		
		override public function setAction():void
		{
			action = { 
				action:"coo",
				response:function(target:*):String {
							return "Who's a pretty boy now? Pretty boy, pretty boy!";
						}
			};
		}
	}


}