package objects.gettables 
{
	import objects.Gettable;

	public class Biscuit extends Gettable
	{		
		public function Biscuit() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Biscuit";
		}
		
		override public function setAlias():void
		{
			alias = ["biscuit", "Biscuit"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A small biscuit. It crumbles and flakes in your hand.";
		}
		
		override public function setAction():void
		{
			action = { 
				action:"feed biscuit to parrot", 
				//parameter:new CorridorRoom,
				response:function(target:*):String {
							//target.personHandler.addPerson("objects.npcs.Parrot", new CorridorRoom);
							return "You feed the biscuit to the parrot";
						}
			};
		}
		
	}


}