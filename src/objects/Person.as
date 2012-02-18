package objects 
{

	public class Person 
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var dialogue:Array;
		// These should be arrays, item would refer only to items in the description, not items in the room
		//public var item:Array<Items>;
		//public var exit:Array<Exits>;
		//public var cloneObject:Array<Objects>;
		// This would look for a specific action (eg: search rock) and then execute the function attached
		//public var action:Function;
 
		function Person()
		{
			setShortDesc();
			setLongDesc();
			setDialogue();
		}
		
		public function setShortDesc():void
		{
			//shortDesc = "Short.";
		}
		
		public function setLongDesc():void
		{
			//longDesc = "This is a long description";
			// Must manually add this to each class that overrides setLongDesc()
		}
		
		public function setDialogue():void
		{
			//dialogue = ["A bit of dialogue"];
		}
		
	}


}