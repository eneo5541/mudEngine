package objects.gettables.house 
{
	import objects.Container;

	public class Closet extends Container
	{		
		public function Closet() 
		{
			super();
			isGettable = false;
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "An old closet";
		}
		
		override public function setAlias():void
		{
			alias = ["old closet", "closet"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "An old, rickety closet.";
		}
	}

}