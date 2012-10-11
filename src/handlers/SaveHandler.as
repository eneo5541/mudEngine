package handlers 
{
	import flash.net.SharedObject;
	import objects.User;
	import parser.TextParser;
	import parser.Utils;

	public class SaveHandler 
	{
		private var savedGame:SharedObject = SharedObject.getLocal("mudEngineSave");
		
		public function SaveHandler() 
		{
		}
		
		public function saveGame(target:TextParser):void
		{
			savedGame.data.room = target.roomHandler.room;	
			
			savedGame.data.npcs = Utils.cloneArray(target.roomHandler.personHandler.personArray);
			savedGame.data.items = Utils.cloneArray(target.roomHandler.gettableHandler.gettableArray);
			
			savedGame.data.userName = target.roomHandler.user.userName;
			savedGame.data.userRace = target.roomHandler.user.userRace;
			savedGame.data.userGender = target.roomHandler.user.userGender;
			savedGame.data.userJob = target.roomHandler.user.userJob;
			savedGame.data.experience = target.roomHandler.user.experience;
			savedGame.data.level = target.roomHandler.user.level;
			
			savedGame.flush();
		}
		
		public function isGameSaved():Boolean
		{
			if (!savedGame.data.room)
				return false;
			else
				return true;
		}
		
		public function getUser():User
		{
			var user:User = new User();
			user.userName = savedGame.data.userName;
			user.userRace = savedGame.data.userRace;
			user.userGender =  savedGame.data.userGender;
			user.userJob = savedGame.data.userJob;
			user.experience = savedGame.data.experience;
			user.level = savedGame.data.level;
			
			return user;
		}
		
		public function getRoom():String
		{
			return savedGame.data.room;
		}
		
		public function getInventory():Array
		{
			return savedGame.data.inventory;
		}
		
		public function getNpcs():Array
		{
			return savedGame.data.npcs;
		}
		
		public function getItems():Array
		{
			return savedGame.data.items;
		}
	}

}