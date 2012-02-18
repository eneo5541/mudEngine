package objects.gettables 
{
	import objects.Gettable;

	public class Binoculars extends Gettable
	{		
		public function Binoculars() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Binoculars";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A pair of binoculars. You could see really far with these.";
		}
		
	}


}