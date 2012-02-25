package objects.npcs 
{
	import objects.Person;
	import objects.rooms.BathRoom;
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
							target.loadRoom(new BathRoom);
							return "Who's a pretty boy now? Pretty boy, pretty boy!";
						}
			};
		}
	}

}


/*
PARAMETERS
	parameter:{ room:new DeadEndRoom },
	parameter:{ npc:new Parrot },
	parameter:{ gettable:new Watch },

RESPONSES
	target.loadRoom(new BathRoom);
	target.personHandler.addPerson("objects.npcs.Parrot", new CorridorRoom);
	target.personHandler.removePerson("objects.npcs.Parrot");
	target.gettableHandler.addGettable("objects.gettables.Knife", new BedRoom);
	target.gettableHandler.removeGettable("objects.gettables.Biscuit");
*/