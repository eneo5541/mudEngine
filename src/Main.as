package 
{
	import fl.controls.UIScrollBar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import parser.OutputEvent;
	import parser.TextParser;
	
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var userInputField:TextField;
		private var userOutputField:TextField;
		private var parse:TextParser = new TextParser();
		private var outputScroll:UIScrollBar = new UIScrollBar(); 
		
		private var my_css:StyleSheet = new StyleSheet();
		
		private var pastCommand:String = "";
		
		public function Main():void 
		{						
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);			
        }
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			userOutputField = createCustomTextField(0, 0, 625, 430);
			userOutputField.multiline = true; 
			userOutputField.wordWrap = true;
			
			userInputField = createCustomTextField(0,430,640,50);
			userInputField.type = TextFieldType.INPUT
			
			outputScroll.direction = "vertical"; 
			outputScroll.setSize(userOutputField.width, userOutputField.height);  
			outputScroll.move(625,0); 
			addChild(outputScroll); 
			
			var td:String = "p { font-family: Verdana; font-size: 12px;text-align:left;color:#ffffff; }.title { color:#00ff00; }.exits { color:#00ffff; } ";
			my_css.parseCSS(td);
			userOutputField.styleSheet = my_css;
			
			var format1:TextFormat = new TextFormat();
			format1.size = 12;
			format1.color = 0xffffff;
			format1.font = "Verdana";
			userInputField.defaultTextFormat = format1;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			parse.addEventListener(OutputEvent.OUTPUT, outputHandler);
			
			parse.parseCommand("look");
		}
		
        private function createCustomTextField(x:int,y:int,width:int,height:int):TextField 
        {			
            var result:TextField = new TextField();
            result.x = x;
            result.y = y;
			result.width = width;
			result.height = height;
			result.border = true;
			result.borderColor = 0xffffff;
			result.text = "";
            addChild(result);
            return result;
        }
		
		private function outputHandler(e:OutputEvent):void
		{
			userOutputField.htmlText += "<div>" + e.value + "</div>";  // Using div tags allows the truncate function to remove specific blocks of text.
			// Truncate the text field if it is too long (to save memory)
			if (userOutputField.numLines > 200)
				truncateOutput(userOutputField.numLines, 200); 
			
			// Scroll to the bottom of the text field
			userOutputField.scrollV = userOutputField.bottomScrollV;
			outputScroll.scrollTarget = userOutputField; 
		}
		
		private function truncateOutput(textLines:int, targetLines:int):void
		{
			var str:String = userOutputField.htmlText;
			
			var minCharacterIndex:int = userOutputField.getLineOffset(textLines - targetLines);
			var maxCharacterIndex:int = userOutputField.htmlText.length;
			var offsetIndex:int = str.indexOf("</div>", minCharacterIndex) + 6;   // Using htmlText, we have to remove the excess text in chunks of divs, as set by the outputHandler. 
			userOutputField.htmlText = str.substr(offsetIndex, maxCharacterIndex); 
		}
		
		private function detectKey(event:KeyboardEvent):void
		{
			if (event.keyCode == 13)
			{
				pastCommand = userInputField.text;
				
				userOutputField.htmlText += "<div><p>>" + userInputField.text + "</p></div>";
				
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
		
	}
	
}



/*
PARAMETERS
	parameter:{ room:new DeadEndRoom, error:"You are not in the dead end room" },
	parameter:{ npc:new Parrot, error:"You don't see any parrot here." },
	parameter:{ gettable:new Watch, error:"You need a watch to salute the butler" },

RESPONSES
	target.loadRoom(new BathRoom);
	target.personHandler.addPerson("objects.npcs.Parrot", new CorridorRoom);
	target.personHandler.removePerson("objects.npcs.Parrot");
	target.gettableHandler.addGettable("objects.gettables.Knife", new BedRoom);
	target.gettableHandler.removeGettable("objects.gettables.Biscuit");
*/