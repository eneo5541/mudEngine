package objects.rooms.house 
{
	import handlers.holders.InventoryHolder;
	import objects.gettables.house.Treat;
	import objects.npcs.house.Butler;
	import objects.Room;

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
			"to the southwest. Those couches sure look comfy.";
		}
		
		override public function setExits():void
		{
			exits["east"] = Hallway;
			exits["southwest"] = Kitchen;
		}
		
		override public function setNpcs():void
		{
			npcs = [ Butler ];
		}
		
		override public function setItems():void
		{
			items["couches"] = "Three plush couches line the walls. They look like they would be very comfortable to sit on.";
			items["table"] = "A small, round table. It has seen plenty of use.";
			items["walls"] = "Simple white walls.";
			items["hallway"] = "The hallway leads to the rest of the house.";
			items["balcony"] = "There is a delicious smell coming from the kitchen.";
		}
		
		override public function setAction():void
		{
			actions = [ { 
				keywords:[
				["sit"],
				["couch", "couches"],
				],
				excluded: { gettable:Treat, error:"You sit on the couch." },
				response:function (target:*):void {
						target.outputText('You sit on the couch and find a dog treat between the cushions, which you quickly pocket.');
						target.addGettable(Treat, InventoryHolder);
						target.reloadRoom();
					}
			}];
		}
	}

}