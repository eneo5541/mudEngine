package handler 
{
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
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
		public var npcs:*;
		public var gettables:*;
		
		//private var _butler:Butler;
		//private var _dog:Dog;
		//private var npcObjects:Array = new Array();
		
		function RoomHandler()
		{
		}
		 
		public function loadRoom(room:Room):void
		{
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			this.npcs = room.npcs;
			this.gettables = room.gettables;
	
			//this.dispatchEvent(new OutputEvent(this.longDesc,OutputEvent.OUTPUT));
		}
		
		public function getDescription():String 
		{
			return longDesc + addExits() + addNpcs() + addGettables() + "\n";
		}
		
		public function addExits():String
		{
			var objectList:Array = addToRoom(exits);
			var tr:String = listHandler.listExits(objectList);
			return tr;
		}
		
		public function addNpcs():String
		{
			var objectList:Array = addToRoom(npcs);
			var tr:String = listHandler.listNpcs(objectList);
			return tr;
		}
		
		public function addGettables():String
		{
			var objectList:Array = addToRoom(gettables);
			var tr:String = listHandler.listGettables(objectList);
			return tr;
		}
		
		
		public function addToRoom(target:*):Array
		{
			if (target == null) return [];
			// Converts all of the anonymous objects into an array		
			var obj:* = target;
			var objectList:Array = [];
			
			for (var i:* in obj) 
				objectList.push(i);
			
			return objectList;
		}
		
	}
	
}