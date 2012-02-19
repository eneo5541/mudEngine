package handler 
{
	import objects.Gettable;
	import objects.Person;

	public class PersonHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var dialogue:Array;
		public var alias:Array;
		
		function PersonHandler()
		{
		}
		
		public function loadPerson(person:Person):void
		{
			this.shortDesc = person.shortDesc;
			this.longDesc = person.longDesc;
			this.dialogue = person.dialogue;
			this.alias = person.alias;
		}
		
	}
	
}