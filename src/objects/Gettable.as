package objects 
{

	public class Gettable 
	{
		public var shortDesc:String = "";
		public var longDesc:String = "";
		public var alias:Array = [];
		public var action:* = null;
 
		function Gettable()
		{
			setShortDesc();
			setLongDesc();
			setAlias();
			setAction();
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
		
		public function setAction():void
		{
			//action = { action:"search table", response:function():void { trace("You search the table"); } };
		}
		
	}


}