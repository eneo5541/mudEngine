package objects.gettables.house 
{
	import objects.Gettable;
	import objects.npcs.house.Butler;
	import objects.npcs.house.Parrot;
	import objects.rooms.house.Livingroom;

	public class Whistle extends Gettable
	{		
		public function Whistle() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "Tin whistle";
		}
		
		override public function setAlias():void
		{
			alias = ["whistle"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A battered tin whistle. The butler might know what to do with this, if you showed him it.";
		}
		
		override public function setAction():void
		{
			actions = [{ 
				action:["show whistle to butler"],
				parameter: { npc:Butler, error:"You don't know how to show whistle to butler." },
				restart: { npc:Parrot, error:"The butler stares at you and points to the parrot that he just summoned with your whistle. He only has the one parrot." },
				response:showWhistle
			},
			{ 
				action:["blow whistle", "use whistle", "play whistle"],
				response:blowWhistle
			}];
		}
		
		private function showWhistle(target:*):void
		{
			var text:String = 'The butler inspects the whistle as you hand it to him. Holding it to his lips, he gives it a shrill whistle that fills the room. You can hear wingbeats in the distance ' +
			'and soon a large, majestic parrot comes to rest on his shoulder.'
			target.outputText(text);
			
			target.addPerson(Parrot, Livingroom);
			target.removeGettable(Whistle);
		}
		
		private function blowWhistle(target:*):void
		{
			target.outputText("Try as you might, you just can't seem to make any noise with the whistle. Perhaps someone else would be able to show you.");
		}
	}


}