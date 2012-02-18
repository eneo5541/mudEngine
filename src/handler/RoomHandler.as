package handler 
{
	import flash.utils.getDefinitionByName;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.Person;
	import objects.Room;

	public class RoomHandler
	{
		public var shortDesc:String;
		public var longDesc:String;
		public var exits:*;
		public var items:*;
		public var npcs:*;
		public var object:*;
		
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
			this.object = room.object;
		
		//	npcObjects = [];	
		//	loadNpcs();  // No need to load the rooms NPCs for the moment, but this will be used later to randomly print NPC dialogue to the screen
		}
		
		/*public function loadNpcs():void
		{
			if (npcs == null) return;
			
			var obj:* = npcs;
			for (var i:* in obj) 
			{
				var mainClass:Class = getDefinitionByName(obj[i]) as Class;
				npcObjects.push(new mainClass as Person);
			}
		}*/
	}
	
}