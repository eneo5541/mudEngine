package objects 
{
	import parser.Utils;

	public class User 
	{
		public var userName:String;
		public var userRace:String;
		public var userGender:String;
		public var userJob:String;
		public var experience:int = 0;
		public var level:int = 1;
		
		function User()
		{
			level = 1;
			experience = 0;
		}	
	}


}