package objects.gettables.house 
{
	import objects.Gettable;
	import objects.rooms.house.Kitchen;

	public class Herbs extends Gettable
	{		
		public function Herbs() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A sprig of parsley";
		}
		
		override public function setAlias():void
		{
			alias = ["parsley", "sprig"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "This sprig of parsley has a rich aroma. It would go well, if added to some soup.";
		}
		
		override public function setAction():void
		{
			actions = [{ 
				action:["add parsley to soup", "add sprig to soup", "add parsley to pot", "add sprig to pot"],
				parameter: { room:Kitchen, error:"There's no soup to add this to!" },
				response:addHerbs
			}];
		}
		
		private function addHerbs(target:*):void
		{
			target.outputText('You crush up the sprig of parsley and sprinkle it onto the soup. Mmm, that smells good.');
			target.removeGettable(Herbs);
		}
	}


}