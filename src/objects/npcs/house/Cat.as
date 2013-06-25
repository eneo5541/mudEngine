package objects.npcs.house 
{
	import handlers.holders.NPCHolder;
	import objects.Person;
	import objects.rooms.house.Outdoors;

	public class Cat extends Person
	{		
		public function Cat() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Cat";
		}
		
		override public function setAlias():void
		{
			alias = ["cat"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "The cat meows as it slinks around your feet, before padding over to the door. She places her paws on the door and purrs at you. You should probably let her out. \n" +
			"She is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The cat weaves between your feet.",
				"The cat scratches at the door impatiently."
			];
		}
		
		override public function setAction():void
		{
			actions = [ { 
				keywords:[
				["let"],
				["cat"],
				["out"],
				],
				response:function (target:*):void {
						target.outputText('The cat scampers outside as you hold the door open.');
						target.movePerson(Cat, NPCHolder);
						target.addPerson(CatOutdoors, Outdoors)
						target.reloadRoom();
					}
				}];
		}
		
	}


}