package objects.gettables 
{
	import objects.Gettable;

	public class Watch extends Gettable
	{		
		public function Watch() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Watch";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A silver watch. The casing is scratched and the watch face it chipped, but is still does the job.";
		}
		
	}


}