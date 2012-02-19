package handler 
{
	import objects.Gettable;

	public class InventoryHandler
	{
		public var inventory:Array = [];
		
		function InventoryHandler()
		{
		}
		
		public function addGettable(gettable:Gettable):void
		{
			//var gettableClass:Class = getDefinitionByName(gettableObject[i]) as Class;
			//	gettableArray.push(new gettableClass as Gettable);
			inventory.push(gettable);
		}
		
	}
	
}