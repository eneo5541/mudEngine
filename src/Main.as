package 
{
	import fl.controls.UIScrollBar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import parser.OutputEvent;
	import parser.TextParser;
/*
 * TODO
 * Interaction with objects. Commands matched. Just need to check parameters and run functions
 * Deleting objects, be they npcs or gettables
 * NPC random dialogue
 */

	public class Main extends Sprite 
	{
		private var userInputField:TextField;
		private var userOutputField:TextField;
		private var parse:TextParser = new TextParser();
		private var outputScroll:UIScrollBar = new UIScrollBar(); 
		
		private var pastCommand:String = "";
		
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
			
			outputScroll.direction = "vertical"; 
			outputScroll.setSize(userOutputField.width, userOutputField.height);  
			outputScroll.move(625,0); 
			addChild(outputScroll); 
			
			
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
			// Truncate the text field if it is too long (to save memory)
			if (userOutputField.numLines > 200)
				truncateOutput(userOutputField.numLines, 200);
		}
		
		
		private function truncateOutput(textLines:int, targetLines:int):void
		{
			var str:String = userOutputField.text;
			var minCharacterIndex:int = userOutputField.getLineOffset(textLines - targetLines);
			var maxCharacterIndex:int = userOutputField.length;
			
			userOutputField.text = str.substr(minCharacterIndex, maxCharacterIndex);
		}
		
		private function detectKey(event:KeyboardEvent):void
		{
			if (event.keyCode == 13)
			{
				pastCommand = userInputField.text;
				userOutputField.appendText(">" + userInputField.text + "\n");
				// Pass the user's input to the textParser to look for commands			
				parse.parseCommand(userInputField.text);
				
				userInputField.text = "";
				// Scroll to the bottom of the text field
				userOutputField.scrollV = userOutputField.bottomScrollV;
				outputScroll.scrollTarget = userOutputField; 
			}
			else if (event.keyCode == 38)  // If up key is pressed, put the last command into the input field
			{
				userInputField.text = pastCommand;
			}
			else if (event.keyCode == 40)  // If down is pressed, clear the input
			{
				userInputField.text = "";
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
	}
	
}