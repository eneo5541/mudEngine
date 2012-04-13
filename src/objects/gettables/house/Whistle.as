package objects.gettables.house 
{
	import objects.Gettable;
	import objects.npcs.house.Butler;
	import objects.npcs.house.Dog;
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
			action = { 
				action:["show whistle to butler"],
				parameter: { npc:Butler, error:"I don't know how to show whistle to butler." },
				restart: { npc:Parrot, error:"The butler stares at you and points to the parrot that he just summoned with your whistle. He only has the one parrot." },
				response:function(target:*):void {
						var text:String = 'The butler inspects the whistle as you hand it to him. Holding it to his lips, he gives it a shrill whistle that fills the room. You can hear wingbeats in the distance ' +
						'and soon a large, majestic parrot comes to rest on his shoulder.'
						target.outputText(text);
						target.addPerson(Parrot, Livingroom);
						target.removeGettable(Whistle);
						}
			};
		}
		
	}


}