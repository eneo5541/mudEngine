package objects.gettables 
{
	import handler.InventoryHandler;
	import objects.Gettable;
	import objects.npcs.Parrot;
	import objects.rooms.BedRoom;
	import objects.rooms.DeadEndRoom;

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
				parameter:{ npc:new Parrot },
				response:function(target:*):String {
							target.gettableHandler.removeGettable("objects.gettables.Biscuit");
							return "You feed the biscuit to the parrot.";
						}
			};
		}
		
	}


}