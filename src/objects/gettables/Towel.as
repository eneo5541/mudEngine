package objects.gettables 
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
			shortDesc = "Towel";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A fluffy pink towel. You decide that it goes wonderfully with your clothes.";
		}
		
	}


}