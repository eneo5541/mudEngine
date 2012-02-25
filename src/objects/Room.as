package objects 
{

	public class Room 
	{
		public var shortDesc:String = "";
		public var longDesc:String = "";
		public var exits:* = null;
		public var items:* = null;
		public var npcs:Array = [];
		public var gettables:Array = [];
		public var action:* = null;
 
		function Room()
		{			
			setExits();	
			setNpcs();
			setGettables();
			setItems();
			setShortDesc();
			setLongDesc();
			setAction();
		}
		// Extend the room object, then override these functions
		public function setExits():void
		{
			//exits = { exit:"objects.Room" };
		}
		
		public function setItems():void
		{
			//items = { item:"A non-descript item." };
		}
		
		public function setGettables():void
		{
			//gettables = { Gettable:"objects.Gettable" };
		}
		
		public function setShortDesc():void
		{
			//shortDesc = "Short.";
		}
		
		public function setNpcs():void
		{
			//npcs = { Person:"objects.Person" };
		}
		
		public function setLongDesc():void
		{
			//longDesc = "This is a long description";
		}
		
		public function setAction():void
		{
			//action = { action:"search table", response:function():void { trace("You search the table"); } };
		}
		
	}


}