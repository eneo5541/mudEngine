package handlers 
{
	import flash.display.InteractiveObject;
	import flash.utils.getQualifiedClassName;
	import objects.Room;
	/**
	 * ...
	 * @author eric
	 */
	public class MapHandler 
	{
		private var mappedRooms:Array;
		
		private static var north:String = '|';
		private static var south:String = '|';
		private static var east:String = '-';
		private static var west:String = '-';
		private static var northeast:String = '/';
		private static var southeast:String = '\\';
		private static var northwest:String = '\\';
		private static var southwest:String = '/';
		
		private var map:Array;
		
		public function MapHandler() 
		{
			mappedRooms = [];
		}
		
		public function generateMap(startingRoom:Room):void
		{
			map = new Array();
			map[0] = new Array();
			map[0] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[1] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[2] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[3] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[4] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			
			remap(startingRoom, 2, 7);
			
			var mapString:String = '';
			var comma:RegExp = /,/g;
			
			for (var i:* in map) 
			{
				var mapLine:String = new String(map[i]);
				mapString += "\n" + mapLine.replace(comma, "");
			}
			
			trace(mapString);
		}
		
		
		private function remap(newRoom:Room, startingX:int, startingY:int):void
		{
			var roomName:String = getQualifiedClassName(newRoom);
			var alreadyExists:Boolean = false;
			for (var i:String in mappedRooms) 
			{
				if (roomName == mappedRooms[i])
					alreadyExists = true;
			}
			
			if (alreadyExists)
				return;
			
			map[startingX][startingY] = 'X';
			mappedRooms.push(roomName);
			
			var savedX:int = startingX;
			var savedY:int = startingY;
			var obj:* = newRoom.exits;
			for (var j:* in obj)
			{
				startingX = savedX;
				startingY = savedY;
				switch(j)
				{
					case 'north':
						startingX--;
						map[startingX][startingY] = north;
						startingX--;
						break;
					case 'south':
						startingX++;
						map[startingX][startingY] = south;
						startingX++;
						break;
					case 'east':
						startingY++;
						map[startingX][startingY] = east;
						startingY++;
						break;
					case 'west':
						startingY--;
						map[startingX][startingY] = west;
						startingY--;
						break;
					case 'northeast':
						startingX--;
						startingY++;
						map[startingX][startingY] = northeast;
						startingX--;
						startingY++;
						break;
					case 'southeast':
						startingX++;
						startingY++;
						map[startingX][startingY] = southeast;
						startingX++;
						startingY++;
						break;
					case 'northwest':
						startingX--;
						startingY--;
						map[startingX][startingY] = northwest;
						startingX--;
						startingY--;
						break;
					case 'southwest':
						startingX++;
						startingY--;
						map[startingX][startingY] = southwest;
						startingX++;
						startingY--;
						break;
					default:
						continue;
						break;
				}
				
				remap(new obj[j] as Room, startingX, startingY);
			}
			
		}
		
	}

}