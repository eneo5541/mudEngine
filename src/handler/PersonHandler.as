package handler 
{
	import flash.utils.getDefinitionByName;
	import objects.Gettable;
	import objects.Person;

	public class PersonHandler
	{
		public var personArray:Array = [];
		
		function PersonHandler()
		{
		}
		
		public function addPerson(personObj:String, loc:String):void  // See gettableHandler for how this works
		{
			for (var i:* in personArray)
			{
				if (personArray[i].person == personObj) 
					return;
			}
			
			personArray.push({ person:personObj, location:loc });
		}
		
		public function personsThisRoom(room:String):Array
		{
			var personsInRoom:Array = [];
			
			for (var i:* in personArray)
			{
				if (personArray[i].location == room) 
				{
					var personClass:Class = getDefinitionByName(personArray[i].person) as Class;
					personsInRoom.push((new personClass).shortDesc);
				}
			}	
			
			return personsInRoom;
		}
		
	}
	
}