package objects 
{

	public class Person 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var alias:Array;
		public var dialogue:Array;
 
		function Person()
		{
			setShortDesc();
			setLongDesc();
			setDialogue();
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
		
		public function setDialogue():void
		{
			//dialogue = ["A bit of dialogue"];
		}
		
		public function setAlias():void
		{
			//alias = ["human", "man", "person"];
		}
		
	}


}