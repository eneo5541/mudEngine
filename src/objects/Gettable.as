package objects 
{

	public class Gettable 
	{
		public var short:String = "";
		public function get shortDesc():String
		{
			return short
		}
		public function set shortDesc(value:String):void
		{
			short = value;
		} 
		
		public var long:String = "";
		public function get longDesc():String
		{
			return long
		}
		public function set longDesc(value:String):void
		{
			long = value;
		} 
		
		public var actionList:Array = [];
		public function get actions():Array
		{
			return actionList;
		}
		public function set actions(value:Array):void
		{
			actionList = value;
		} 
		
		public var alias:Array = [];
		public var isGettable:Boolean = true;
		
		function Gettable()
		{
			setShortDesc();
			setLongDesc();
			setAlias();
			setAction();
		}
		
		public function setShortDesc():void
		{
		}
		
		public function setLongDesc():void
		{
		}
		
		public function setAlias():void
		{
		}
		
		public function setAction():void
		{
		}
		
	}

}