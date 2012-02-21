package objects.npcs 
{
	import objects.Person;
	import objects.rooms.CorridorRoom;

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
			alias = ["Butler", "butler", "servant", "man"];
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
		
		override public function setAction():void
		{
			action = { 
				action:"salute butler", 
				parameter:new CorridorRoom,
				response:function(target:*):String {
							target.personHandler.addPerson("objects.npcs.Parrot", new CorridorRoom);
							return "As you salute the Butler, a parrot swoops into the room, perching on his shoulder.";
						}
			};
		}
		
	}


}