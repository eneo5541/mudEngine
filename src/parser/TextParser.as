package parser 
{
	public class TextParser
	{
		private var firstName:String;
		private var lastName:String;
		
		function TextParser()
		{
		 
		}
		 
		public function parseCommand(command:String):String
		{
			if (command.length == 0)
				return "\n";
			var splitSpaces:Array = command.split(" ");
			var output:String;
			
			switch (splitSpaces[0])
			{
				case "look":case "l":
					output = "You look around";
					break;
				case "north":case "south":case "east":case "west":case "n":case "s":case "e":case "w":
					output = "You leave out the " + splitSpaces[0] + " exit";
					break;
				case "search":case "sear":
					output = "You search around";
					break;
				case "use":
					output = "You use an item";
					break;
				default:
					output = "I don't know how to " + splitSpaces[0];
					break;
			}
			
			return output + "\n";
		}
	}
	
}