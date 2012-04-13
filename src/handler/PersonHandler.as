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
		
		public function movePerson(personObj:*, loc:*):void  // Change the location of an existing person
		{
			if (!(personObj is String)) 
				personObj = getQualifiedClassName(personObj);
			
			var personIndex:int = -1;
			for (var i:* in personArray)
			{
				if (personArray[i].object == personObj) 
					personIndex = i;
			}
			if (personIndex < 0) return; // Do not run if the person does not exist
			
			if (!(loc is String)) 
				loc = getQualifiedClassName(loc);
			
			personArray[personIndex].location = loc;   // Go to the index of the person object and change the location.
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
		
		
		public function checkNPCExists(command:String, loc:*=null):String   // Checks whether an input command matches any object aliases and returns the appropriate object
		{
			if (loc != null)
			{
				if (!(loc is String))
					loc = getQualifiedClassName(loc);
			}
			
			for (var i:* in personArray) // Iterate through all the objects in existance
			{
				var personObj:Class = getDefinitionByName(personArray[i].object) as Class;
				var child:* = new personObj;
				for (var j:* in child.alias)  // Then iterate all the aliases for that object
				{
					if (command == child.alias[j])  // If the inputted command matches any of the object's aliases
					{
						if (loc == null)   // If no location parameter specified, return true
						{
							return personArray[i].object;
						}
						else
						{
							if (personArray[i].location == loc)  // Otherwise, also check if the object's location matches the parameter
								return personArray[i].object;
						}
					}
				}
			}
			
			return null;
		}
		
		public function getNPCDescript(getObj:*):String
		{
			if (!(getObj is String))
					getObj = getQualifiedClassName(getObj);
			
			for (var i:* in personArray) // Iterate through all the objects in existance
			{
				if (personArray[i].object == getObj)
				{
					var personObj:Class = getDefinitionByName(personArray[i].object) as Class;
					var child:* = new personObj;
					return child.longDesc;
				}
			}
			
			return null;
		}
		
		public function searchPersons(getObj:*):Boolean
		{
			if (!(getObj is String))
					getObj = getQualifiedClassName(getObj);
			
			for (var i:* in personArray)
			{
				if (getObj == personArray[i].object)
					return true;
			}
			
			return false;
		}
		
	}
	
}