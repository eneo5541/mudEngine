package objects.npcs.house 
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
		
		override public function setAlias():void
		{
			alias = ["dog"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A cute dog. He sits around the room, wagging his tail and looking around with a huge grin on his face. \n" +
			"He is in excellent condition.";
		}
		
		override public function setDialogue():void
		{
			dialogue = [
				"The dog barks at the walls.",
				"The dog scuttles about while sniffing the floor."
			];
		}
		
		override public function setAction():void
		{
			actions = [{ 
				action:["pet dog", "pet the dog"],
				response:petDog
			},
			{ 
				action:["scratch dog", "scratch the dog"],
				response:scratchDog
			}];
		}
		
		private function petDog(target:*):void
		{
			target.outputText('The dog barks and drools profusely.');
		}
		
		private function scratchDog(target:*):void
		{
			target.outputText('The dog rolls over as you scratch him behind the ears.');
		}
	}


}