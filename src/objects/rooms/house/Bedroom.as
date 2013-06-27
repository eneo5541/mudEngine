package objects.rooms.house 
{
	import handlers.holders.InventoryHolder;
	import objects.gettables.house.Ball;
	import objects.gettables.house.Closet;
	import objects.npcs.house.Dog;
	import objects.Room;

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
			longDesc = "You are in a simple bedroom. There is a bed and a chest here. A door leads out, to the west. ";
		}
		
		override public function setExits():void
		{
			exits["west"] = Hallway;
		}
		
		override public function setNpcs():void
		{
			npcs = [ Dog ];
		}
		
		override public function setGettables():void
		{
			gettables = [ Closet ];
		}
		
		override public function setItems():void
		{
			items["bed"] = "A neatly made bed.";
			items["chest"] = "A nice, wooden chest. It is closed.";
			items["door"] = "The door leads out, to the west.";
		}
		
		override public function setAction():void
		{
			actions = [{ 
				keywords:[
				["open"],
				["chest"],
				],
				excluded: { gettable:Ball, error:"You open the chest, but there is nothing inside." },
				response:function (target:*):void {
						target.outputText('You open the chest and find a tennis ball inside.');
						target.addGettable(Ball, InventoryHolder);
						target.reloadRoom();
					}
			}];
		}
		
	}


}