package handler 
{
	import flash.utils.getDefinitionByName;
	import objects.Gettable;
	import objects.Person;

	public class GettableHandler
	{
		public var gettableArray:Array = [];
		
		function GettableHandler()
		{
		}
		
		public function addGettable(getObj:String, loc:String):void
		{
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].gettable == getObj)  // If the object is already in the array, do not add it.
					return;
			}
			
			gettableArray.push({ gettable:getObj, location:loc });
		}
		
		public function gettablesThisRoom(room:String):Array
		{
			var gettablesInRoom:Array = [];
			
			for (var i:* in gettableArray)
			{
				if (gettableArray[i].location == room)  // If the object is in the given room, return it.
				{
					var gettableClass:Class = getDefinitionByName(gettableArray[i].gettable) as Class;
					gettablesInRoom.push((new gettableClass).shortDesc);
				}
			}	
			
			return gettablesInRoom;
		}
		
	}
	
}