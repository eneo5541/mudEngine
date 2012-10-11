package objects.npcs.house 
{
	import objects.Person;
	import objects.rooms.house.Outdoors;

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
		
		override public function setAlias():void
		{
			alias = ["Butler"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A well-dressed butler. He is wearing a pressed black suit and holds a cloth in one hand. \n" +
			"He is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The butler wipes a fleck of dust off of his suit.",
				"The butler smiles at you as you pass."
			];
		}
		
		override public function setConversations():void
		{
			conversations = [
				"I think some parsley would make a fine addition to our soup. There may be some outside the kitchen.",
				"Have a seat - the couches are very comfortable.",
				"I believe I put a hat away in the bedroom closet. You can have it, if you like."
			];
		}
		
	}


}