package objects.rooms.house 
{
	import objects.Room;
	import objects.gettables.house.Hat;
	import objects.npcs.house.Dog;

	public class Bedroom extends Room
	{	
		public function Bedroom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Bedroom</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are in a simple bedroom. There is a bed and a closet here. A door leads out, to the west. ";
		}
		
		override public function setExits():void
		{
			exits = { west:Hallway };
		}
		
		override public function setNpcs():void
		{
			npcs = [ Dog ];
		}
		
		override public function setItems():void
		{
			items = {
				bed:"A neatly made bed.",
				closet:"A nice, wooden closet. It is closed. ",
				door:"The door leads out, to the west."
			};
		}

		override public function setAction():void
		{
			actions = [{ 
				action:["open closet"],
				restart: { gettable:Hat, error:"You open the closet, but there is nothing inside." },
				response:useSink
			}];
		}
		
		private function useSink(target:*):void
		{
			target.outputText('You open the closet and find a hat inside.');
			target.addGettable(Hat, Bedroom);
		}
		
	}


}