package objects.gettables.house 
{
	import objects.Gettable;

	public class Hat extends Gettable
	{		
		public function Hat() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A fancy hat";
		}
		
		override public function setAlias():void
		{
			alias = ["hat"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A stylish grey fedora. You would probably look amazing wearing it.";
		}
		
		override public function setAction():void
		{
			action = { 
				action:["wear hat"],
				response:wearHat
			};
		}
		
		private function wearHat(target:*):void
		{
			target.outputText('You put the hat on your head and tweak it off to an angle.');
		}
		
	}


}