package handler 
{

	public class ListHandler
	{
		
		function ListHandler()
		{
		}
		
		public function listExits(list:Array):String
		{		
			var listString:String = "";
			listString = list[0];
			
			for (var i:int = 1; i < list.length; i++)
			{
				if(i < (list.length-1)) 
					listString += ", " + list[i];
				else
					listString += " and " + list[i];
			}
			
			return listString + ".";
		}
		
		public function listNpcs(list:Array):String
		{		
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
		
		public function listObjects(list:Array):String
		{		
			var listString:String = "";
			
			for (var i:int = 0; i < list.length; i++)
			{
				if(i < (list.length-1)) 
					listString += list[i] + ".\n";
				else
					listString += list[i];
			}
			return listString;
		}
		
	}

}