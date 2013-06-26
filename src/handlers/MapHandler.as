package handlers 
{
	import flash.utils.getQualifiedClassName;
	import objects.Room;

	public class MapHandler 
	{
		private static var gridSize:int = 100;
		private static var vertical:String = ' |';   // North and south
		private static var horizontal:String = '-';   // East and west
		private static var rightDiagonal:String = '/';   // Northeast and southwest
		private static var leftDiagonal:String = '\\';   // Northwest and southeast
		
		private var mappedRooms:Array;
		private var map:Array;
		
		public function MapHandler() 
		{
			mappedRooms = new Array();
			map = new Array();
		}
		
		public function generateMap(startingRoom:Room):String
		{
			createNewMap();   // Creates a grid for the rooms and exits to go on. Assumes that the map, generated from the middle of the grid, will not extend outside of the grid boundaries
			
			mapRoom(startingRoom, gridSize/2, gridSize/2, true);    // Start generating the map with the first room, at the middle of the map
			
			map = map.filter(removeEmptyRows);    // Filter out all the rows that did not have any rooms or exits added to them
			var totalEmptyColumns:int = countEmptyColumns(map);   // Remove all the columns that do not have any data at them, until the left-most point of the map is in the first column
			for (var i:* in map) 
			{
				for (var j:int = 0; j < totalEmptyColumns; j++) 
				{
					map[i].shift();
				}
			}
			
			return mapToString();   // Convert the map's arrays to strings
		}
		
		private function createNewMap():void
		{
			mappedRooms = [];
			map = [];
			
			for (var x:int = 0; x < gridSize; x++) 
			{
				var dummyRow:Array = [" "];
				for (var y:int = 0; y < gridSize; y++) 
				{
					dummyRow.push(" ");
				}
				map.push(dummyRow);
			}
		}
		
		private function mapRoom(newRoom:Room, startingX:int, startingY:int, playerIsHere:Boolean=false):void
		{
			var roomName:String = getQualifiedClassName(newRoom);
			for (var i:String in mappedRooms)    // Store each room that's been mapped. Prevents rooms being remapped back and forth.
			{
				if (roomName == mappedRooms[i])
					return;
			}
			
			mappedRooms.push(roomName);
			
			var spanStart:String = newRoom.shortDesc.split(">")[0] + ">";   // Take the colour of the room's shortDesc and use it to colour that room in the map
			var spanStop:String = "</span>";
			
			if (playerIsHere)
				map[startingX][startingY] = "<span class='main'>X</span>";
			else
				map[startingX][startingY] = spanStart + "O" + spanStop;
			
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
						startingX--;	// For each exit, offset the coordinates to the exit's location relative to the room
						map[startingX][startingY] = spanStart +  vertical + spanStop;   // Draw the direction symbol for the exit 
						startingX--;    // Offset again for the room attached to the exit
						break;
					case 'south':
						startingX++;
						map[startingX][startingY] = spanStart + vertical + spanStop;
						startingX++;
						break;
					case 'east':
						startingY++;
						map[startingX][startingY] = spanStart + horizontal + spanStop;
						startingY++;
						break;
					case 'west':
						startingY--;
						map[startingX][startingY] = spanStart + horizontal + spanStop;
						startingY--;
						break;
					case 'northeast':
						startingX--;
						startingY++;
						map[startingX][startingY] = spanStart + rightDiagonal + spanStop;
						startingX--;
						startingY++;
						break;
					case 'southeast':
						startingX++;
						startingY++;
						map[startingX][startingY] = spanStart + leftDiagonal + spanStop;
						startingX++;
						startingY++;
						break;
					case 'northwest':
						startingX--;
						startingY--;
						map[startingX][startingY] = spanStart + leftDiagonal + spanStop;
						startingX--;
						startingY--;
						break;
					case 'southwest':
						startingX++;
						startingY--;
						map[startingX][startingY] = spanStart + rightDiagonal + spanStop;
						startingX++;
						startingY--;
						break;
					default:
						continue;
						break;
				}
				
				mapRoom(new obj[j] as Room, startingX, startingY);   // For each exit, take the room assigned to that exit and add it to the map
			}
		}
		
		private function removeEmptyRows(element:Array, index:int, array:Array):Boolean
		{
			for (var j:* in element) 
			{
				if (element[j] != " ")
					return true;
			}
			
			return false;
		}
		
		private function countEmptyColumns(array:Array):int
		{
			var emptyColumns:int = gridSize;
			for (var i:* in array) 
			{
				for (var j:* in array[i]) 
				{
					if (array[i][j] != " " && j < emptyColumns)
					{
						emptyColumns = j;
						break;
					}
				}
			}
			
			return emptyColumns;
		}
		
		private function mapToString():String
		{
			var mapString:String = "";
			var comma:RegExp = /,/g;
			for (var i:* in map) 
			{
				var mapLine:String = new String(map[i]);
				mapString += "\n" + mapLine.replace(comma, "");
			}
			
			return mapString;
		}
		
	}
	
}