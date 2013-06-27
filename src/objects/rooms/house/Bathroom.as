package objects.rooms.house 
{
	import objects.gettables.house.Towel;
	import objects.Room;

	public class Bathroom extends Room
	{	
		public function Bathroom() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "<span class='green'>Bathroom</span>";
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A tidy, functional bathroom. There is a sink built into the counter, as well as a neatly folded stack of towels. There is a hallway to the north.";
		}
		
		override public function setExits():void
		{
			exits["north"] = Hallway;
		}
		
		override public function setGettables():void
		{
			gettables = [ Towel ];
		}
		
		override public function setItems():void
		{
			items["sink"] = "A simple ceramic bowl with a faucet. You can use it.";
			items["bowl"] = "A simple ceramic bowl with a faucet. You can use it.";
			items["faucet"] = "A simple ceramic bowl with a faucet. You can use it.";
			items["counter"] = "The black marble counter is very shiny.";
			items["towels"] = "Three pink towels have been neatly folded and placed onto the counter, beside the sink.";
			items["stack"] = "Three pink towels have been neatly folded and placed onto the counter, beside the sink.";
			items["hallway"] = "The hallway leads to the rest of the house.";
		}

		override public function setAction():void
		{
			actions = [ { 
				keywords:[
				["use", "turn"],
				["sink", "faucet", "bowl", "tap"],
				],
				response:function useSink(target:*):void {
						target.outputText("You turn on the water and rinse your hands.");
					}
			}];
		}
		
	}


}