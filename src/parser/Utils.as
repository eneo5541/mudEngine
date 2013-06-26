package parser 
{
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Utils 
	{
		
		public function Utils() 
		{
		}
		
		public static function capitalize(target:String):String
		{
			var firstLetter:String = target.substr(0, 1).toUpperCase();
			var restOfWord:String = target.substr(1, target.length).toLowerCase()
			
			return firstLetter + restOfWord;
		}
		
		public static function generateRandom(max:Number, min:Number = 0):Number
		{
			 return int(Math.random() * (max - min) + min);
		}
		
		public static function createTextField(x:int,y:int,width:int,height:int):TextField 
        {
			var padding:Number = 6;
			
            var result:TextField = new TextField();
			result.x = x + 40 + padding;
			result.y = y + padding;
			result.width = width - 40 - (padding*2) - 15;
			result.height = height - (padding * 2);
			result.text = "";
            return result;
        }
		
		public static function listExits(list:Array):String
		{	
			var listString:String = "";
			listString = list[0];
			if (list.length == 1)
				return "\nThere is an exit to the " + listString + ".";
			
			for (var i:int = 1; i < list.length; i++)
			{
				if(i < (list.length-1)) 
					listString += ", " + list[i];
				else
					listString += " and " + list[i];
			}
			
			return "\nThere are exits to the " + listString + ".";
		}
		
		public static function listNpcs(list:Array):String
		{
			if (list == null || list.length == 0) return "";
			
			var listString:String = "";
			listString = list[0];
			
			if (list.length == 1)
				return listString + " is here.";
			
			for (var i:int = 1; i < list.length; i++)
			{
				if(i < (list.length-1)) 
					listString += ", " + list[i];
				else
					listString += " and " + list[i];
			}
			
			return listString + " are here.";
		}
		
		public static function listGettables(list:Array):String
		{		
			if (list == null || list.length == 0) return "";
			
			var listString:String = "";
			
			for (var i:int = 0; i < list.length; i++)
			{
				if(i < (list.length-1)) 
					listString += list[i] + ".\n";
				else
					listString += list[i] + ".";
			}
			
			return listString;
		}
		
		public static function cloneArray(source:Object):* 
		{ 
			var byteArray:ByteArray = new ByteArray(); 
			byteArray.writeObject(source); 
			byteArray.position = 0; 
			return(byteArray.readObject()); 
		}	
		
		public static function getObjectShortDesc(getObj:*):String
		{
			if (!(getObj is String))
				getObj = getQualifiedClassName(getObj);
			
			try
			{
				var obj:Class = getDefinitionByName(getObj) as Class;
				var child:* = new obj;
				return child.shortDesc;
			}
			catch (error:Error)
			{
				trace(error.message);
			}
			return null;
		}
		
		public static function getDirectionFromShortcut(shortcut:String):String
		{
			switch(shortcut)
			{
				case "n":
					return "north";
				case "s":
					return "south";
				case "e":
					return "east";
				case "w":
					return "west";
				case "ne":
					return "northeast";
				case "se":
					return "southeast";
				case "nw":
					return "northwest";
				case "sw":
					return "southwest";
				case "u":
					return "up";
				case "d":
					return "down";
				default:
					return shortcut;
			}
		}
	}

}