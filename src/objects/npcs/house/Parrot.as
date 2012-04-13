package objects.npcs.house 
{
	import objects.Person;

	public class Parrot extends Person
	{		
		public function Parrot() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Brightly coloured parrot";
		}
		
		override public function setAlias():void
		{
			alias = ["parrot"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "This parrot's plumage is a striking blue and yellow. It is the size of a football and is clearly domesticated, given how at ease it is around you. \n" +
			"He is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The parrot caws loudly."
			];
		}
	}


}