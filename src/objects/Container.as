package objects 
{
	import flash.utils.getDefinitionByName;
	import parser.Utils;

	public class Container extends Gettable
	{
		override public function get longDesc():String
		{
			var newDesc:String = long;
			/*if (isClosed)
			newDesc += "\nIt is closed.";
			else
			newDesc += "\nIt is open.";
			trace(">>>"+newDesc)*/
			/*if (!isClosed)
			{
				var shortDescripts:Array = [];
				for (var i:* in contents)
				{
					shortDescripts.push((new contents[i]).shortDesc);
				}
				newDesc += "\n" + ((shortDescripts.length == 0) ? "It is empty" : "It contains:\n" + Utils.listGettables(shortDescripts));
			}*/
			
			return newDesc;
		}

		
		public var contents:Array = [];
		
		public function Container()
		{
			super();
			setContents();
		}
		
		public function setContents():void
		{
		}
	}
}