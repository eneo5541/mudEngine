package 
{
	import fl.controls.UIScrollBar;
	import fl.managers.FocusManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getQualifiedClassName;
	
	import objects.rooms.house.Bedroom;
	import parser.Utils;
	import signals.OutputEvent;
	import parser.TextParser;
	

	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var userInputField:TextField;
		private var userOutputField:TextField;
		private var rectangle:TextField;
		private var parse:TextParser;
		
		private var outputScroll:UIScrollBar = new UIScrollBar(); 
		private var outputCSS:StyleSheet = new StyleSheet();
		private var whiteText:String = ".main { font-family: Verdana;font-size: 12px;text-align:left;color:#ffffff; } .black { color:#808080; } .red { color:#ff0000; } .green { color:#00ff00; } .yellow { color:#ffff00; } .blue { color:#0000ff; } .magenta { color:#ff00ff; } .cyan { color:#00ffff; } .white { color:#ffffff; }";
		private var formatText:TextFormat = new TextFormat();
		private var isTextBlack:Boolean = true;
		
		private var pastCommand:String = "";
		private var pastCommand2:Array = new Array();
		private var commandStackCounter:int = 0;
		private var maxTextLines:int = 350;
		private var menu:ContextMenu = new ContextMenu();
		private var focusManager:FocusManager;
		
		public function Main():void 
		{						
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);			
        }
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			stage.align=StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			outputCSS.parseCSS(whiteText);
			
			formatText.size = 12;
			formatText.color = 0xffffff;
			formatText.font = "Verdana";
			
			rectangle = Utils.createTextField(0, 0, 800, 600);
			addChild(rectangle);
			rectangle.border = true;
			rectangle.borderColor = 0xffffff;
			rectangle.background = true;
			rectangle.backgroundColor = 0x000000;
			rectangle.type = TextFieldType.DYNAMIC;
			rectangle.selectable = false;
			rectangle.mouseEnabled = false;
			rectangle.tabEnabled = false;
			
			userOutputField = Utils.createTextField(0, 0, 785, 540);
			addChild(userOutputField);
			userOutputField.multiline = true; 
			userOutputField.wordWrap = true;
			userOutputField.styleSheet = outputCSS;
			
			userInputField = Utils.createTextField(0, 552, 800, 48);
			addChild(userInputField);
			userInputField.type = TextFieldType.INPUT
			userInputField.border = true;
			userInputField.borderColor = 0xffffff;
			userInputField.defaultTextFormat = formatText;
			
			outputScroll.direction = "vertical"; 
			outputScroll.setSize(15, userOutputField.height+11);  
			outputScroll.move(785,1); 
			addChild(outputScroll); 
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			
			focusManager = new FocusManager(this);
			focusManager.setFocus(userInputField);
			
			createParser(Bedroom); // This makes all the objects compile into the .swf, as they are all strongly referenced, branching out from the starting room
		}
	
		private function createParser(startRoom:*):void
		{
			if (!(startRoom is String)) 
				startRoom = getQualifiedClassName(startRoom);
				
			parse = new TextParser(startRoom);
			parse.addEventListener(OutputEvent.OUTPUT, outputHandler);
			parse.parseCommand("look");
		}
		
		private function outputHandler(e:OutputEvent):void
		{			
			userOutputField.htmlText += "<div><span class='main'>\n" + e.value + "</span></div>";  // Using div tags allows the truncate function to remove specific blocks of text.
			
			if (userOutputField.numLines > maxTextLines)   // Truncate the text field if it is too long (to save memory)
				truncateOutput(userOutputField.numLines, maxTextLines); 
			
			userOutputField.scrollV = userOutputField.bottomScrollV;  // Scroll to the bottom of the text field
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
			if (focusManager.getFocus() != userInputField) // Do not execute key commands unless user input is selected
				return;
			
			if (event.keyCode == 13)
			{
				handleCommandStack(userInputField.text);
				
				userOutputField.htmlText += "<div><span class='main'>\n>" + userInputField.text + "</span></div>";
				
				parse.parseCommand(userInputField.text);   // Pass the user's input to the textParser to look for commands
				
				userInputField.text = "";
				
				userOutputField.scrollV = userOutputField.bottomScrollV;  // Scroll to the bottom of the text field
				outputScroll.scrollTarget = userOutputField; 
			}
			else if (event.keyCode == 38)  // If up key is pressed, put the last command into the input field
			{
				if (commandStackCounter > 0)
				{
					commandStackCounter--;
					if(pastCommand2[commandStackCounter] != null)
						userInputField.text = pastCommand2[commandStackCounter];
				}
			}
			else if (event.keyCode == 40)  // If down is pressed, clear the input
			{
				if (commandStackCounter < pastCommand2.length-1)
				{
					commandStackCounter++;
					if(pastCommand2[commandStackCounter] != null)
						userInputField.text = pastCommand2[commandStackCounter];
				}
				else 
				{
					userInputField.text = "";
				}
			}
		}
		
		private function handleCommandStack(newCommand:String):void
		{
			pastCommand2.push(newCommand);
			
			if (pastCommand2.length > 10)
				pastCommand2.shift();
			
			commandStackCounter = pastCommand2.length;
		}
		
	}

}