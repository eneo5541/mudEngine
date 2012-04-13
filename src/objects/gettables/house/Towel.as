package objects.gettables.house 
{
	import objects.Gettable;

	public class Towel extends Gettable
	{		
		public function Towel() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Hand towel";
		}
		
		override public function setAlias():void
		{
			alias = ["towel"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A fluffy white towel. It feels nice and plush to the touch.";
		}
		
	}


}