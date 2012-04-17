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
			action = { 
				action:["add parsley to soup", "add sprig to soup"],
				parameter: { room:Kitchen, error:"There's no soup to add this to!" },
				response:function(target:*):void {
						var text:String = 'You crush up the sprig of parsley and sprinkle it into the soup. Mmm, that smells good. ';
						target.outputText(text);
						target.removeGettable(Herbs);
						}
			};
		}
		
	}


}