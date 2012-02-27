package handler 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import objects.Gettable;
	import objects.Person;

	public class PersonHandler
	{
		public var personArray:Array = [];
		
		function PersonHandler()
		{
		}
		
		public function addPerson(personObj:*, loc:*):void  // See gettableHandler for how this works
		{
			if (!(personObj is String)) 
				personObj = getQualifiedClassName(personObj);
			
			for (var i:* in personArray)
			{
				if (personArray[i].object == personObj) 
					return;
			}
			
			if (!(loc is String))   // Convert the location to a string for storage
				loc = getQualifiedClassName(loc);
			
			personArray.push( { object:personObj, location:loc } );
		}
		
		public function removePerson(personObj:*):void  // As above, see gettableHandler
		{
			if (!(personObj is String)) 
				personObj = getQualifiedClassName(personObj);
			
			for (var i:* in personArray)
			{
				if (personArray[i].object == personObj) 
				{
					personArray.splice(i, 1); 
					//personArray[i].location = "DUMMY";  
					return; 
				}
			}	
		}
		
		public function personsThisRoom(room:String):Array
		{
			var personsInRoom:Array = [];
			
			for (var i:* in personArray)
			{
				if (personArray[i].location == room) 
				{
					var personClass:Class = getDefinitionByName(personArray[i].object) as Class;
					personsInRoom.push(new personClass as Person);
				}
			}	
			
			return personsInRoom;
		}
		
	}
	
}