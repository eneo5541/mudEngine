package parser 
{
	import flash.display.Sprite;
	import objects.User;
	import signals.OutputEvent;
	
	public class Sheet extends Sprite
	{
		public var user:User = new User();	
		
		public function Sheet() 
		{
		}
		
		public function getSheet():String
		{
			var character:String = 'You are a non-descript ' + user.userRace + ' ' + user.userGender + '.\n\n';
			
			var stats:String = 'You have the following statistics:\n'+
			'Name : ' + user.userName + '\n'+
            'Race : ' + Utils.capitalize(user.userRace) + '\n'+
			'Gender : ' + Utils.capitalize(user.userGender) + '\n'+
			'Job : ' + user.userJob + '\n';
			
			var level:String = '\nLevel : ' + user.level + '\n'+
			'Exp : ' + user.experience + ' / ' + (user.level * 1000);
			
			return character + stats + level;
		}
		
		public function incrementExperience(quantity:int):void
		{
			user.experience += quantity;
			
			var xpNeeded:int = user.level * 1000;
			if (user.experience > xpNeeded)
			{
				user.level++;
				this.dispatchEvent(new OutputEvent("\nAdvancing to level " + user.level + "...", OutputEvent.OUTPUT));
			}
		}
		
	}

}