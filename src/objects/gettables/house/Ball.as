package objects.gettables.house 
{
	import flash.utils.getQualifiedClassName;
	import objects.Gettable;
	import objects.npcs.house.Dog;
	import objects.rooms.house.Bedroom;
	import objects.rooms.house.Hallway;

	public class Ball extends Gettable
	{		
		public function Ball() 
		{
			super();
		}
		
		override public function setShortDesc():void
		{
			shortDesc = "A chewed up tennis ball";
		}
		
		override public function setAlias():void
		{
			alias = ["ball", "tennis ball", "chewed up tennis ball", "chewed up ball"];
		}
		
		override public function setLongDesc():void
		{
			longDesc = "A tatty looking tennis ball. Its been badly chewed up.";
		}
		
		override public function setAction():void
		{
			actions = [{ 
				keywords:[
				["throw"],
				["ball"],
				],
				required: { npc:Dog, error:"The ball rolls around the ground before coming to rest back at you're feet. You are so lonely." },
				response:function (target:*):void {
						var output:String = "";
						if (target.room == getQualifiedClassName(Bedroom))
						{
							output = 'You fling the ball down the hallway, prompting the dog to bound after it.';
							target.movePerson(Dog, Hallway);
							target.moveGettable(Ball, Hallway);
						}
						else if (target.room == getQualifiedClassName(Hallway))
						{
							output = 'The dog clomps after the ball as you toss it back into the bedroom.';
							target.movePerson(Dog, Bedroom);
							target.moveGettable(Ball, Bedroom);
						}
						
						target.outputText(output);
						target.addExperience(100);
					}
			}];
		}
	}


}