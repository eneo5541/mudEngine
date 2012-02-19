package handler 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import objects.Gettable;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.Person;
	import objects.Room;
	import parser.OutputEvent;

	public class RoomHandler extends EventDispatcher
	{
		private var listHandler:ListHandler = new ListHandler();
		
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var npcs:Array;
		public var gettables:Array;
		
		//private var _butler:Butler;
		//private var _dog:Dog;
		//private var npcObjects:Array = new Array();
		
		function RoomHandler()
		{
		}
		
		public function loadRoom(room:Room):void
		{	
			this.npcs = loadNpcs(room.npcs)
			this.gettables = loadGettables(room.gettables);
			
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			
		}
		
		private function loadNpcs(target:*):Array
		{
			var npcObject:* = target;
			var npcArray:Array = [];
			for (var i:* in npcObject) 
			{ 
				var personClass:Class = getDefinitionByName(npcObject[i]) as Class;
				npcArray.push(new personClass as Person);
				//personHandler.loadPerson(new personClass as Person);
			}
			return npcArray;
		}
		
		private function loadGettables(target:*):Array
		{
			var gettableObject:* = target;
			var gettableArray:Array = [];
			for (var i:* in gettableObject) 
			{ 
				var gettableClass:Class = getDefinitionByName(gettableObject[i]) as Class;
				gettableArray.push(new gettableClass as Gettable);
			}
			return gettableArray;
		}
		
		
		public function getDescription():String 
		{
			return longDesc + addExits() + addNpcs() + addGettables() + "\n";
		}
		
		private function addExits():String
		{	
			if (this.exits == null) return ""; // Converts all of the anonymous objects into an array		
			
			var obj:* = this.exits;
			var objectList:Array = [];
			for (var i:* in obj) 
				objectList.push(i);
			
			var tr:String = listHandler.listExits(objectList);
			return tr;
		}
		
		private function addNpcs():String
		{
			var td:Array = [];
			for (var i:* in npcs) 
				td.push(npcs[i].shortDesc);
			
			var tr:String = listHandler.listNpcs(td);
			return tr;
		}
		
		private function addGettables():String
		{
			var td:Array = [];
			for (var i:* in gettables) 
				td.push(gettables[i].shortDesc);
				
			var tr:String = listHandler.listGettables(td);
			return tr;
		}
		
	}
	
}