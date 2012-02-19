package objects 
{

	public class Gettable 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var alias:Array;
 
		function Gettable()
		{
			setShortDesc();
			setLongDesc();
			setAlias();
		}
		
		public function setShortDesc():void
		{
			//shortDesc = "Short.";
		}
		
		public function setLongDesc():void
		{
			//longDesc = "This is a long description";
		}
		
		public function setAlias():void
		{
			//alias = ["rock", "pebble", "stone"];
		}
		
	}


}