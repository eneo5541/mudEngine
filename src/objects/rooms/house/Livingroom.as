package objects.rooms.house 
{
	import objects.Room;
	import handler.InventoryHolder;
	import objects.gettables.house.Treat;
	import objects.npcs.house.Butler;

	public class Livingroom extends Room
	{	
		public function Livingroom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Livingroom</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "Several plush couches line the walls of this spacious living room. A sturdy looking coffee table has been placed in the middle. There is a hallway to the east, and a kitchen " +
			"to the southwest.";
		}
		
		override public function setExits():void
		{
			exits = { east:Hallway,
					southwest:Kitchen };
		}
		
		override public function setNpcs():void
		{
			npcs = [ Butler ];
		}
		
		override public function setItems():void
		{
			items = {
				couches:"Three plush couches line the walls. They look like they would be very comfortable to sit on.",
				table:"A small, round table. It has seen plenty of use.",
				walls:"Simple white walls.",
				hallway:"The hallway leads to the rest of the house.",
				kitchen:"There is a delicious smell coming from the kitchen."
			};
		}

		override public function setAction():void
		{
			action = { 
				action:["sit couches", "sit on couches", "sit couch", "sit on couch"],
				restart: { gettable:Treat, error:"You sit on the couch." },
				response:function(target:*):void {
							var text:String = 'You sit on the couch and find a dog treat between the cushions, which you quickly pocket.';
							target.outputText(text);
							target.addGettable(Treat, InventoryHolder);
						}
			};
		}
		
	}


}