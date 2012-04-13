package parser 
{
	import flash.text.TextField;
	public class Utils 
	{
		
		public function Utils() 
		{
		}
		
		public static function generateRandom(max:Number, min:Number = 0):Number
		{
			 return int(Math.random() * (max - min) + min);
		}
		
		public static function changeCSSTextSize(css:String, size:Number):String
		{
			var temp:Array = css.split('font-size: ');
			var temp2:Array = temp[1].split('px;text-align:');
			
			return temp[0] + 'font-size: ' + size + 'px;text-align:' + temp2[1];
		}
		
		public static function createTextField(x:int,y:int,width:int,height:int):TextField 
        {
            var result:TextField = new TextField();
            result.x = x;
            result.y = y;
			result.width = width;
			result.height = height;
			result.text = "";
            return result;
        }
		
		public static function listExits(list:Array):String
		{		
			if (list == null || list.length == 0) return "\nThere are no visible exits.";
			
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
		
	}

}