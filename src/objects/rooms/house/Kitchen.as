package objects.rooms.house 
{
	import objects.Room;
	import objects.npcs.house.Cat;

	public class Kitchen extends Room
	{	
		public function Kitchen() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Kitchen</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "You are in a small, somewhat cramped kitchen. There is a stovetop here, over which a pot of soup is cooking. There is also a sink with several dishes in it, and a door leading outside. " +
			"You can see a balcony, just beyond the door. To the northeast is the livingroom.";
		}
		
		override public function setExits():void
		{
			exits = { northeast:Livingroom };
		}
		
		override public function setNpcs():void
		{
			npcs = [ Cat ];
		}
		
		override public function setItems():void
		{
			items = {
				stovetop:"A stovetop with four heating elements. A pot of soup is cooking on one of them.",
				pot:"A large pot of delicious smelling soup. It smells like... bacon. If only you had some parsley to add to this.",
				soup:"A large pot of delicious smelling soup. It smells like... bacon. If only you had some parsley to add to this.",
				sink:"The sink has several dirty dishes in it, awaiting a good washing.",
				dishes:"Three dirty looking plates sit in the sink.",
				balcony:"A door separates the kitchen from the balcony outside.",
				door:"This door leads outside. It is closed."
			};
		}

		override public function setAction():void
		{
			action = { 
				action:["open door"],
				response:openDoor
			};
		}
		
		private function openDoor(target:*):void
		{
			target.outputText('You open the door and step outside.');
			target.loadRoom(new Outdoors);
		}
		
	}


}