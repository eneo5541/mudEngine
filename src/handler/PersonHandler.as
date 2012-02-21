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
		
		public function addPerson(personObj:String, loc:*):void  // See gettableHandler for how this works
		{
			for (var i:* in personArray)
			{
				if (personArray[i].object == personObj) 
					return;
			}
			
			var td:String = loc;
			if (!(loc is String))   // Convert the location to a string for storage
				td = getQualifiedClassName(loc);
			
			personArray.push( { object:personObj, location:td } );
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