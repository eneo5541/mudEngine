package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import parser.OutputEvent;
	import parser.TextParser;
/*
 * TODO
 * Items and NPCs should be moved to separate arrays (the handlers?) 
 * The room's item and NPC arrays only denote the STARTING location of the item/npc. 
 * The new location can be changed by changing the object's location in the array
 */

	public class Main extends Sprite 
	{
		private var userInputField:TextField = new TextField(); 
		private var userOutputField:TextField = new TextField();
		private var parse:TextParser = new TextParser();
		
		public function Main():void 
		{						
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.graphics.beginFill(0xFFCC00);
            this.graphics.drawRect(0, 0, 400, 300);
            this.graphics.endFill();
			
			userInputField.type = TextFieldType.INPUT;
			userInputField.x = 0; 
			userInputField.y = 270;
            userInputField.width = 400; 
			userInputField.height = 30;
			userInputField.border = true;
			userInputField.borderColor = 0xff0000;
			userInputField.text = "";
			addChild(userInputField); 
			
			userOutputField = new TextField();
			userOutputField.multiline = true; 
			userOutputField.wordWrap = true;
			userOutputField.x = 0; 
			userOutputField.y = 00;
            userOutputField.width = 400;
			userOutputField.height = 270;
			userOutputField.border = true;
			userOutputField.borderColor = 0x0000ff;
			userOutputField.text = "";
			this.addChild(userOutputField);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			parse.addEventListener(OutputEvent.OUTPUT, outputHandler);
			
			parse.parseCommand("look");
		}
		
		public function outputHandler(e:OutputEvent):void
		{
			userOutputField.appendText(e.value);
		}
		
		private function detectKey(event:KeyboardEvent):void
		{
			if (event.keyCode == 13)
			{
				userOutputField.appendText(">" + userInputField.text + "\n");
				// Pass the user's input to the textParser to look for commands
				//var str:String = parse.parseCommand(userInputField.text);
				//userOutputField.appendText(str);
				
				parse.parseCommand(userInputField.text);
				
				userInputField.text = "";
				// Scroll to the bottom of the text field
				userOutputField.scrollV = userOutputField.bottomScrollV;
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
	}
	
}