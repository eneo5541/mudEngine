package parser
{
	import flash.display.Sprite;
	import handlers.SaveHandler;
	import objects.User;
	import parser.Utils;
	import signals.IntroEvent;
	import signals.OutputEvent;
	
	
	public class Intro extends Sprite
	{		
		public var isIntroRunning:Boolean;
		private var introStage:int;
		private var user:User = new User();
		private var isFirstRun:Boolean = true;
		private var saveHandler:SaveHandler = new SaveHandler();
		
		public function Intro() 
		{
			isIntroRunning = true;
			introStage = 0;
		}

// Requests to user. Outputs to screen, then waits for input.
		public function introText():void
		{
			if(isFirstRun) {
				outputIntroText("Generic Text Based Game\n\n");
				isFirstRun = false;
			}
			
			switch(introStage)
			{
				case 0:
					checkIfSaved();
					break;
				case 1:
					askForName();
					break;
				case 2:
					askForRace();
					break;
				case 3:
					askForGender();
					break;
				case 4:
					askForJob();
					break;
				case 5:
					finishedIntro();
					break;
				case 6:case 9:
					startGameProper();
					break;
				case 11:
					loadGame();
					return;
				default:
					return;
			}
		}

// Responses from user. On input received, calls appropriate function, then increments counter and moves to next stage in introText()
		public function parseIntroText(target:String):void
		{
			switch(introStage)
			{
				case 0:
					checkIfLoadGame(target);
					break;
				case 1:
					checkName(target);
					break;
				case 2:
					checkRace(target);
					break;
				case 3:
					checkGender(target);
					break;
				case 4:
					checkJob(target);
					break;
				case 5:
					enterGame(target);
					break;
				default:
					return;
			}
			introStage++;
			introText();
		}

// Requests to user
		private function checkIfSaved():void
		{
			if (!saveHandler.isGameSaved())
			{
				introStage = 1;
				introText();
				return;
			}
			
			var intro:String = "You currently have a saved game. Selection an option: [resume/start]";
			outputIntroText(intro);
		}
		
		private function askForName():void
		{
			var intro:String = "Welcome to the Generic Text Based Game. What name do you wish to be known by?";
			outputIntroText(intro);
		}
		
		private function askForRace():void
		{
			var intro:String = 	"Hail, " + user.userName + "! \n" +
				"What race do you hail from?";
			outputIntroText(intro);
		}
		
		private function askForGender():void
		{
			var intro:String = "A fine example of a " + user.userRace + "! \n" +
				"What is your gender?";
			outputIntroText(intro);
		}
		
		
		private function askForJob():void
		{
			var intro:String = 	"Last question - what is your chosen profession in our world?";
			outputIntroText(intro);
		}
		
		private function finishedIntro():void
		{
			var intro:String = "You have created a character!\n" +
			"Welcome to the Generic Text Based Game!\n\n" +
			"[Press enter to continue]";
			outputIntroText(intro);
		}

//Responses from user
		private function checkIfLoadGame(newGame:String):void
		{
			newGame = newGame.toLowerCase();
			
			if (newGame == "resume") {
				outputIntroText("Loading saved game...");
				introStage = 10;
			}
			else if (newGame == "start") {
				outputIntroText("Ok, starting new game...");
			}
			else {
				outputIntroText("Not a valid choice. Try again");
				introStage = -1;
			}
		}
		
		private function checkName(newName:String):void
		{
			if (newName.length == 0) 
			{
				user.userName = "Alex";
				outputIntroText("No name? Your name is 'Alex' then.");
			}
			else
			{
				user.userName = Utils.capitalize(newName);
			}
		}
		
		private function checkRace(newRace:String):void
		{
			if (newRace.length == 0) 
			{
				user.userRace = "human";
				outputIntroText("No race? You are a human then.");
			}
			else 
			{
				user.userRace = newRace;
			}
		}
		
		private function checkGender(newGender:String):void
		{
			newGender = newGender.toLowerCase();
			switch(newGender)
			{	
				case "male":case "m":case "guy":case "dude":case "man":case "boy":
					user.userGender = "male";
					break;
				case "female":case "f":case "lady":case "woman":case "chick":case "girl":
					user.userGender = "female";
					break;
				default:
					user.userGender = "male";
					outputIntroText("No gender? Very well - enjoy being a male.");
					break;
			}
		}
		
		private function checkJob(newJob:String):void
		{			
			if (newJob.length == 0) 
			{
				user.userJob = "Professional Goat Masturbator";
				outputIntroText("No job either? Here, have this one - you are now a professional goat masturbator. Enjoy your new job.");
			}
			else 
			{
				user.userJob = Utils.capitalize(newJob);
			}
		}
		
		private function enterGame(startTutorial:String):void
		{
			// Place holder so that intro will pause rather than immediately enter the game.
		}
		
		private function startGameProper():void
		{
			isIntroRunning = false;
			this.dispatchEvent(new IntroEvent(user, IntroEvent.STARTGAME, true, true));
		}
		
		private function loadGame():void
		{
			isIntroRunning = false;
			this.dispatchEvent(new IntroEvent(null, IntroEvent.LOADGAME, true, true));
		}

// Output to screen
		private function outputIntroText(target:String):void
		{
			this.dispatchEvent(new OutputEvent(target, OutputEvent.OUTPUT));
		}
	}

}