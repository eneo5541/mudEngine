package objects 
{
	import flash.utils.Dictionary;

	public class Room 
	{
		public var shortDesc:String = "";
		public var longDesc:String = "";
		public var exits:Dictionary = new Dictionary();
		public var items:Dictionary = new Dictionary();
		public var npcs:Array = [];
		public var gettables:Array = [];
		public var actions:Array = [];
		
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
		
		public function setExits():void
		{
		}
		
		public function setItems():void
		{
		}
		
		public function setGettables():void
		{
		}
		
		public function setShortDesc():void
		{
		}
		
		public function setNpcs():void
		{
		}
		
		public function setLongDesc():void
		{
		}
		
		public function setAction():void
		{
		}
		
	}


}