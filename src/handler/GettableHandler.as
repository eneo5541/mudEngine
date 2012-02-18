package handler 
{
	import objects.Gettable;
	import objects.Person;

	public class GettableHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		
		function GettableHandler()
		{
		}
		
		public function loadGettable(person:Gettable):void
		{
			this.shortDesc = person.shortDesc;
			this.longDesc = person.longDesc;
		}
		
	}
	
}