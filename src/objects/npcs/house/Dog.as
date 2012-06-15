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
			action = { 
				action:["pet dog", "pet the dog"],
				response:function(target:*):void {
						var text:String = 'The dog barks and drools profusely.';
						target.outputText(text);
						}
			};
		}
	}


}