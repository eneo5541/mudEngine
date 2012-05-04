package objects.gettables.house 
{
	import objects.Gettable;
	import objects.npcs.house.Dog;
	import objects.rooms.house.Bedroom;

	public class Treat extends Gettable
	{		
		public function Treat() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Dog biscuit";
		}
		
		override public function setAlias():void
		{
			alias = ["biscuit"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "The dog biscuit crumbles in your hands as you hold it. You'd probably get more use feeding it to some dog.";
		}
		
		override public function setAction():void
		{
			action = { 
				action:["feed biscuit to dog"],
				parameter: { npc:Dog, error:"I don't know how to feed biscuit to dog." },
				restart: { gettable:Whistle, error:"The dog scarfs down the treat and returns to panting and grinning." },
				response:function(target:*):void {
						var text:String = 'The dog wolfs down the treat eagerly before running away. You are annoyed to own such a fair-weather animal, but he returns soon, dropping a small whistle he '+
						'found at your feet. Good dog.';
						target.outputText(text);
						target.removeGettable(Treat);
						target.addGettable(Whistle, Bedroom);
						}
			};
		}
		
	}


}