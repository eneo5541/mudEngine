package objects.gettables 
{
	import objects.Gettable;

	public class Knife extends Gettable
	{		
		public function Knife() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Penknife";
		}
		
		override public function setAlias():void
		{
			alias = ["penknife", "Penknife", "knife"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A red, folding pen knife. It includes a blade, corkscrew, can opener and screw driver.";
		}
		
	}


}