package objects 
{

	public class Container extends Gettable
	{	
		public var contents:Array = [];
		
		public function Container()
		{
			super();
			
			isGettable = false;
			setContents();
		}
		
		public function setContents():void
		{
		}
		
	}
	
}