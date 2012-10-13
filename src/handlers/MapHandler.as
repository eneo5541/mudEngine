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
		private var map:Array;
		
		private static var north:String = '|';
		private static var south:String = '|';
		private static var east:String = '-';
		private static var west:String = '-';
		private static var northeast:String = '/';
		private static var southeast:String = '\\';
		private static var northwest:String = '\\';
		private static var southwest:String = '/';
		
		public function MapHandler() 
		{
			mappedRooms = new Array();
			
			map = new Array();
			map[0] = new Array();
		}
		
		public function generateMap(startingRoom:Room):String
		{
			mappedRooms = [];
			map = [];
			map[0] = [' '];
			
			remap(startingRoom, 0, 0, true);
			
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
			for (var i:String in mappedRooms) 
			{
				if (roomName == mappedRooms[i])
					return;
			}
			
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
						var nValues:* = decrementX(startingX, savedX);
						startingX = nValues.startingX;
						savedX = nValues.savedX;
						
						map[startingX][startingY] = spanStart + north + spanStop;
						
						nValues = decrementX(startingX, savedX);
						startingX = nValues.startingX;
						savedX = nValues.savedX;
						break;
					case 'south':
						var sValues:* = incrementX(startingX);
						startingX = sValues.startingX;
						
						map[startingX][startingY] = spanStart + south + spanStop;
						
						sValues = incrementX(startingX);
						startingX = sValues.startingX;
						break;
					case 'east':
						var eValues:* = incrementY(startingY);
						startingY = eValues.startingY;
						
						map[startingX][startingY] = spanStart+east+spanStop;
						
						eValues = incrementY(startingY);
						startingY = eValues.startingY;
						break;
					case 'west':
						var wValues:* = decrementY(startingY, savedY);
						startingY = wValues.startingY;
						savedY = wValues.savedY;
						
						map[startingX][startingY] = spanStart + west + spanStop;
						
						wValues = decrementY(startingY, savedY);
						startingY = wValues.startingY;
						savedY = wValues.savedY;
						break;
					case 'northeast':
						var neValues:* = decrementX(startingX, savedX);
						startingX = neValues.startingX;
						savedX = neValues.savedX;
						
						neValues = incrementY(startingY);
						startingY = neValues.startingY;
						
						map[startingX][startingY] = spanStart+northeast+spanStop;
						
						neValues = decrementX(startingX, savedX);
						startingX = neValues.startingX;
						savedX = neValues.savedX;
						
						neValues = incrementY(startingY);
						startingY = neValues.startingY;
						break;
					case 'southeast':
						var seValues:* = incrementX(startingX);
						startingX = seValues.startingX;
						
						seValues = incrementY(startingY);
						startingY = seValues.startingY;
						
						map[startingX][startingY] = spanStart+southeast+spanStop;
						
						seValues = incrementX(startingX);
						startingX = seValues.startingX;
						
						seValues = incrementY(startingY);
						startingY = seValues.startingY;
						break;
					case 'northwest':
						var nwValues:* = decrementX(startingX, savedX);
						startingX = nwValues.startingX;
						savedX = nwValues.savedX;
						
						nwValues = decrementY(startingY, savedY);
						startingY = nwValues.startingY;
						savedY = nwValues.savedY;
						
						map[startingX][startingY] = spanStart+northwest+spanStop;
						
						nwValues = decrementX(startingX, savedX);
						startingX = nwValues.startingX;
						savedX = nwValues.savedX;
						
						nwValues = decrementY(startingY, savedY);
						startingY = nwValues.startingY;
						savedY = nwValues.savedY;
						break;
					case 'southwest':
						var swValues:* = incrementX(startingX);
						startingX = swValues.startingX;
						
						swValues = decrementY(startingY, savedY);
						startingY = swValues.startingY;
						savedY = swValues.savedY;
						
						map[startingX][startingY] = spanStart+southwest+spanStop;
						
						swValues = incrementX(startingX);
						startingX = swValues.startingX;
						
						swValues = decrementY(startingY, savedY);
						startingY = swValues.startingY;
						savedY = swValues.savedY;
						break;
					default:
						continue;
						break;
				}
				
				remap(new obj[j] as Room, startingX, startingY, false);
			}
		}
		
		private function incrementX(startingX:int):*
		{
			startingX++;
			if (startingX > map.length-1) 
			{
				var newArray:Array = [];
				for (var i:* in map[0]) 
					newArray.push(' ');
				
				map.push(newArray);
			}
			return { startingX:startingX };
		}
		
		private function decrementX(startingX:int, savedX:int):*
		{
			startingX--;
			if (startingX < 0) 
			{
				var newArray:Array = [];
				for (var i:* in map[0]) 
					newArray.push(' ');
				
				map.unshift(newArray);
				startingX = 0;
				savedX++;
			}
			return { startingX:startingX, savedX:savedX };
		}
		
		private function incrementY(startingY:int):*
		{
			startingY++;
			if (startingY > map[0].length-1) 
			{
				for (var i:* in map) 
					map[i].push(' ');
			}
			return { startingY:startingY };
		}
		
		private function decrementY(startingY:int, savedY:int):*
		{
			startingY--; 
			if (startingY < 0) 
			{
				for (var i:* in map) 
					map[i].unshift(' ');
				startingY = 0;
				savedY++;
			}
			return { startingY:startingY, savedY:savedY };
		}
		
	}

}