package parser 
{
	
	import objects.Gettable;
	import objects.gettables.Binoculars;
	import objects.gettables.Biscuit;
	import objects.gettables.Knife;
	import objects.gettables.Towel;
	import objects.gettables.Watch;
	import objects.npcs.Butler;
	import objects.npcs.Dog;
	import objects.npcs.Parrot;
	import objects.Person;
	import objects.Room;
	import objects.rooms.BathRoom;
	import objects.rooms.BedRoom;
	import objects.rooms.Corridor2Room;
	import objects.rooms.CorridorRoom;
	import objects.rooms.DeadEndRoom;
	import objects.rooms.JunctionRoom;
	import objects.rooms.OutdoorsRoom;
	import objects.rooms.StairsRoom;
	
	public class ObjectLibrary
	{
		// Rooms
		private var _bathroom:BathRoom;
		private var _bedRoom:BedRoom;
		private var _corridorRoom:CorridorRoom;
		private var _corridor2Room:Corridor2Room;
		private var _deadEndRoom:DeadEndRoom;
		private var _junctionRoom:JunctionRoom;
		private var _outdoorsRoom:OutdoorsRoom;
		private var _stairsRoom:StairsRoom;
		// NPCs
		private var _butler:Butler;
		private var _dog:Dog;
		private var _parrot:Parrot;
		// Items
		private var _watch:Watch;
		private var _towel:Towel;
		private var _binoculars:Binoculars;
		private var _knife:Knife;
		private var _biscuit:Biscuit;
		
		
		function ObjectLibrary()
		{
		}
	}
	
}