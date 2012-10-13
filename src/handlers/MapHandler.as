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
			mappedRooms = new Array();
			
			map = new Array();
			map[0] = new Array();
		}
		
		public function generateMap(startingRoom:Room):String
		{
			mappedRooms = [];
			
			map[0] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[1] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[2] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[3] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			map[4] = [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '];
			
			remap(startingRoom, 2, 7, true);
			
			var mapString:String = '';
			var comma:RegExp = /,/g;
			
			for (var i:* in map) 
			{
				var mapLine:String = new String(map[i]);
				mapString += "\n" + mapLine.replace(comma, "");
			}
			
			return mapString;
		}
		
		
		private function remap(newRoom:Room, startingX:int, startingY:int, playerIsHere:Boolean):void
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
			
			var spanStart:String = newRoom.shortDesc.split(">")[0] + '>';
			var spanStop:String = '</span>';
			
			if (playerIsHere)
				map[startingX][startingY] = "<span class='white'>O</span>";
			else
				map[startingX][startingY] = spanStart+'X'+spanStop;
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
						map[startingX][startingY] = spanStart+north+spanStop;
						startingX--;
						break;
					case 'south':
						startingX++;
						map[startingX][startingY] = spanStart+south+spanStop;
						startingX++;
						break;
					case 'east':
						startingY++;
						map[startingX][startingY] = spanStart+east+spanStop;
						startingY++;
						break;
					case 'west':
						startingY--;
						map[startingX][startingY] = spanStart+west+spanStop;
						startingY--;
						break;
					case 'northeast':
						startingX--;
						startingY++;
						map[startingX][startingY] = spanStart+northeast+spanStop;
						startingX--;
						startingY++;
						break;
					case 'southeast':
						startingX++;
						startingY++;
						map[startingX][startingY] = spanStart+southeast+spanStop;
						startingX++;
						startingY++;
						break;
					case 'northwest':
						startingX--;
						startingY--;
						map[startingX][startingY] = spanStart+northwest+spanStop;
						startingX--;
						startingY--;
						break;
					case 'southwest':
						startingX++;
						startingY--;
						map[startingX][startingY] = spanStart+southwest+spanStop;
						startingX++;
						startingY--;
						break;
					default:
						continue;
						break;
				}
				
				remap(new obj[j] as Room, startingX, startingY, false);
			}
		}
		
	}

}