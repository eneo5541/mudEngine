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
			exits = { north:Hallway };
		}
		
		override public function setGettables():void
		{
			gettables = [ Towel ];
		}
		
		override public function setItems():void
		{
			items = {
				sink:"A simple ceramic bowl with a faucet. You can use it.",
				bowl:"A simple ceramic bowl with a faucet. You can use it.",
				faucet:"A simple ceramic bowl with a faucet. You can use it.",
				counter:"The black marble counter is very shiny.",
				towels:"Three pink towels have been neatly folded and placed onto the counter, beside the sink.",
				stack:"Three pink towels have been neatly folded and placed onto the counter, beside the sink.",
				hallway:"The hallway leads to the rest of the house."
			};
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