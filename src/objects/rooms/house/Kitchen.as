package objects.rooms.house 
{
	import objects.npcs.house.Cat;
	import objects.Room;

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
			"To the northeast is the livingroom.";
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
				pot:"A large pot of delicious smelling soup. It smells like... bacon.",
				soup:"A large pot of delicious smelling soup. It smells like... bacon.",
				sink:"The sink has several dirty dishes in it, awaiting a good washing.",
				dishes:"Three dirty looking plates sit in the sink.",
				door:"This door leads outside. It is closed."
			};
		}

		override public function setAction():void
		{
			action = { 
				action:["open door"],
				response:function(target:*):void {
							var text:String = 'You open the door and step outside.';
							target.outputText(text);
							target.loadRoom(new Outdoors);
						}
			};
		}
		
	}


}