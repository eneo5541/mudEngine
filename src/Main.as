package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import parser.OutputEvent;
	import parser.TextParser;
/*
 * TODO
 * Tnteraction with objects
 * Deleting objects, be they npcs or gettables
 * NPC random dialogue
 */

	public class Main extends Sprite 
	{
		private var userInputField:TextField;
		private var userOutputField:TextField;
		private var parse:TextParser = new TextParser();
		
		public function Main():void 
		{						
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
/*			this.graphics.beginFill(0xffffff);
            this.graphics.drawRect(0, 0, 640, 480);
            this.graphics.endFill();*/
			
			userOutputField = createCustomTextField(0, 0, 640, 430);
			userOutputField.multiline = true; 
			userOutputField.wordWrap = true;
			userInputField = createCustomTextField(0,430,640,50);
			userInputField.type = TextFieldType.INPUT
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			parse.addEventListener(OutputEvent.OUTPUT, outputHandler);
			
			parse.parseCommand("look");
        }
		
        private function createCustomTextField(x:int,y:int,width:int,height:int):TextField 
        {
			var format1:TextFormat = new TextFormat();
			format1.size = 16;
			
            var result:TextField = new TextField();
            result.x = x;
            result.y = y;
			result.width = width;
			result.height = height;
			result.border = true;
			result.borderColor = 0x000000;
			result.textColor = 0x000000;
			result.defaultTextFormat = format1;
			result.text = "";
            addChild(result);
            return result;
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