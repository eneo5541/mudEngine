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
		public var action:*;
		public var npcsThisRoom:Array;
		
		
		function RoomHandler()
		{
		}
		
		public function loadRoom(room:Room):void
		{	
			this.room = getQualifiedClassName(room);
			
			loadNpcs(room.npcs);
			loadGettables(room.gettables);
			
			this.exits = room.exits;
			this.items = room.items;
			this.shortDesc = room.shortDesc;
			this.longDesc = room.longDesc;
			this.action = room.action
		}
		
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
			npcsThisRoom = personHandler.personsThisRoom(room);
			
			var toString:Array = [];
			for (var i:* in npcsThisRoom)
				toString.push(npcsThisRoom[i].shortDesc);	
			var tr:String = listHandler.listNpcs(toString);
			
			return tr;
		}
		
		private function addGettables():String
		{
			var td:Array = gettableHandler.gettablesThisRoom(room);
			var tr:String = listHandler.listGettables(td);
			return tr;
		}
		
		public function getResponse(f:Function):String
		{
			return f(this); // The 'this' parameter allows the response function to be called from the roomHandler, instead of the room
		}

	}

	
}