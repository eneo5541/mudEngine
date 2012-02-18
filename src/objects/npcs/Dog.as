package objects.npcs 
{
	import objects.Person;

	public class Dog extends Person
	{		
		public function Dog() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Dog";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A cute corgi. He looks like a twinkie with legs.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The dog barks at you.",
				"The dog hops around happily.",
			];
		}
	}


}