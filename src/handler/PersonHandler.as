package handler 
{
	import objects.Person;

	public class PersonHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var dialogue:Array;
		
		function PersonHandler()
		{
		}
		
		public function loadPerson(person:Person):void
		{
			this.shortDesc = person.shortDesc;
			this.longDesc = person.longDesc;
			this.dialogue = person.dialogue;
		}
		
	}
	
}