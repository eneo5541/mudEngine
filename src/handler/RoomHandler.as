package handler 
{
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import objects.Gettable;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.Person;
	import objects.Room;
	import objects.rooms.BedRoom;
	import parser.OutputEvent;

	public class RoomHandler extends EventDispatcher
	{
		private var listHandler:ListHandler = new ListHandler();
		public var gettableHandler:GettableHandler = new GettableHandler();
		public var personHandler:PersonHandler = new PersonHandler();
		
		public var room:String;
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
			this.room = getQualifiedClassName(room);
			
			//this.npcs = loadNpcs(room.npcs)
			//this.gettables = loadGettables(room.gettables);
			loadNpcs(room.npcs);
			loadGettables(room.gettables);
			
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			
			//var child:Array = gettableHandler.gettableArray;
			//trace(child.length);
			//for (var i:* in child)
			//{
			//	trace(child[i].gettable + " : " + child[i].location);
			//}
		}
		
		
		/*public function deleteGettable(target:int):void 
		{
			//trace(gettables[target].longDesc);
			var splitSpaces:Array = getQualifiedClassName(gettables[target]).split("::");
			var command:String = splitSpaces[0] + "." + splitSpaces[1];
			// Need to delete the object from the room data object, then reload the this.gettables.
			var gettableObject:* = room.gettables;
			var gettableArray:Array = [];
			for (var i:* in gettableObject) 
			{
				if (command == gettableObject[i]) {
					trace("Deleting " + command);
					trace(BedRoom.gettables.length);
					room.gettables.splice(i, 1);
					this.gettables = loadGettables(room.gettables);
					return;
				}
			}
		}*/
		
		/*private function loadNpcs(target:*):Array
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
		}*/
		
		private function loadNpcs(target:*):void
		{
			var npcObject:* = target;
			for (var i:* in npcObject)
				personHandler.addPerson(npcObject[i], room);
		}
		
		private function loadGettables(target:*):void
		{									
			var gettableObject:* = target; // On loadRoom, add that room's objects to the gettableHandler
			for (var i:* in gettableObject)// The handler stores each object, so that it can be manipulated independently of the room				   
				gettableHandler.addGettable(gettableObject[i], room);
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
			var td:Array = personHandler.personsThisRoom(room);
			var tr:String = listHandler.listNpcs(td);
			return tr;
		}
		
		private function addGettables():String
		{
			var td:Array = gettableHandler.gettablesThisRoom(room);
			var tr:String = listHandler.listGettables(td);
			return tr;
		}
		
	}
	
}