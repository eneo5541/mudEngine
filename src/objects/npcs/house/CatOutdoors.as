package objects.npcs.house 
{
	import objects.Person;
	import objects.rooms.house.Kitchen;

	public class CatOutdoors extends Person
	{		
		public function CatOutdoors() 
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
			longDesc = "The same cat as before. It meows as it sits on the balcony, this time hoping for a rub from you. \n" +
			"She is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The cat meows at you."
			];
		}
		
		override public function setAction():void
		{
			actions = [{ 
				keywords:[
				["rub", "pet"],
				["cat"],
				],
				response:function rubCat(target:*):void	{
						target.outputText("You rub the cat's back, causing her to purr happily. Satisfied, she lets herself back in, leaving you alone in the balcony again.");
						target.removePerson(CatOutdoors);
						target.movePerson(Cat, Kitchen);
						target.reloadRoom();
					}
			},
			{ 
				keywords:[
				["let"],
				["cat"],
				["in"],
				],
				response:function (target:*):void {
						target.outputText('The cat paws and bats at your leg as you approach the door, demanding to be pet.');
					}
				}];
		}
		
	}


}