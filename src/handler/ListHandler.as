package handler 
{

	public class ListHandler
	{
		
		function ListHandler()
		{
		}
		
		public function listExits(list:Array):String
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
		
		public function listNpcs(list:Array):String
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
		
		public function listGettables(list:Array):String
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