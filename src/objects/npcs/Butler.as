package objects.npcs 
{
	import objects.Person;

	public class Butler extends Person
	{		
		public function Butler() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Butler";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "The butler is a tall, gaunt man wearing a stylish black-tie suit. " +
			"He stands at attention when you approach. \n" +
			"He is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The butler says 'There's always something to clean.'",
				"The butler asks 'Do you need something?'",
				"The butler wipes a speck of dust off of is suit."
			];
		}
	}


}