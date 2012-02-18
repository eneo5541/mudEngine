package objects 
{
	/**
	 * ...
	 * @author eric
	 */
	public class Room 
	{
		public var shortDesc:String;
		public var longDesc:String;
		// These should be arrays, item would refer only to items in the description, not items in the room
		//public var item:Array<Items>;
		//public var exit:Array<Exits>;
		//public var cloneObject:Array<Objects>;
		// This would look for a specific action (eg: search rock) and then execute the function attached
		//public var action:Function;
 
		function Room()
		{
			setShortDesc();
			setLongDesc();
		}
		
		public function setShortDesc():void
		{
		}
		
		public function setLongDesc():void
		{
		}
		

	}


}