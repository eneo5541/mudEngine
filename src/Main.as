package 
{
	import fl.controls.UIScrollBar;
	import fl.managers.FocusManager;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import handlers.holders.InventoryHolder;
	import handlers.SaveHandler;
	import objects.User;
	import parser.Intro;
	import parser.Utils;
	import parser.TextParser;
	import signals.IntroEvent;
	import signals.OutputEvent;
	import signals.ParserEvent;
	import ui.RoundedTextContainer;
	
	
	public class Main extends Sprite 
	{
		private var userInputField:TextField;
		private var inventoryTitle:TextField;
		private var sheetTitle:TextField;
		private var parse:TextParser;
		
		private var outputScroll:UIScrollBar = new UIScrollBar(); 
		private var outputCSS:StyleSheet = new StyleSheet();
		private var blackText:String = ".map { font-family:Courier New; font-size:13px; text-align:left; color:#000000; }.main { font-family:Tahoma; font-size:13px; text-align:left; color:#000000; letter-spacing:1px; } .black { color:#000000; } .red { color:#800000; } .green { color:#008000; } .yellow { color:#808000; } .blue { color:#000080; } .magenta { color:#800080; } .cyan { color:#008080; } .white { color:#c0c0c0; }";
		private var whiteText:String = ".map { font-family:Courier New; font-size:13px; text-align:left; color:#ffffff; }.main { font-family:Tahoma; font-size:13px; text-align:left; color:#ffffff; letter-spacing:1px; } .black { color:#808080; } .red { color:#ff0000; } .green { color:#00ff00; } .yellow { color:#ffff00; } .blue { color:#0000ff; } .magenta { color:#ff00ff; } .cyan { color:#00ffff; } .white { color:#ffffff; }";
		private var formatText:TextFormat = new TextFormat();
		
		private var pastCommand:String = "";
		private var pastCommand2:Array = new Array();
		private var commandStackCounter:int = 0;
		private var maxTextLines:int = 350;
		private var intro:Intro;
		private var user:User = new User();
		private var saveHandler:SaveHandler = new SaveHandler();
		private var menu:ContextMenu = new ContextMenu();
		private var focusManager:FocusManager;
		
		private var textOutput:RoundedTextContainer;
		private var textInput:RoundedTextContainer;
		private var divider:Shape;
		private var sheetText:RoundedTextContainer;
		private var inventoryText:RoundedTextContainer;
		
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
			
			formatText.size = 13;
			formatText.letterSpacing = 1;
			formatText.color = 0x000000;
			formatText.font = "Tahoma";
			
			
			textOutput = new RoundedTextContainer(229, 14, 857, 646, true);
			textOutput.text.styleSheet = outputCSS;
			addChild(textOutput);
			
			textInput = new RoundedTextContainer(229, 674, 857, 52, true);
			textInput.removeChild(textInput.text);
			addChild(textInput);
			
			divider = new Shape();
			divider.graphics.lineStyle(2, 0x1f1f1f);
			divider.graphics.moveTo(214, 21); 
			divider.graphics.lineTo(214, 719);
			addChild(divider);
			
			sheetText = new RoundedTextContainer(14, 14, 186, 379, false);
			sheetText.text.styleSheet = outputCSS;
			addChild(sheetText);
			
			inventoryText = new RoundedTextContainer(14, 407, 186, 319, false);
			inventoryText.text.styleSheet = outputCSS;
			addChild(inventoryText);
			
			
			userInputField = Utils.createTextField(textInput.x, textInput.y, textInput.width, textInput.height);
			addChild(userInputField);
			userInputField.defaultTextFormat = formatText;
			userInputField.type = TextFieldType.INPUT
			
			inventoryTitle = Utils.createTextField(inventoryText.x+8, inventoryText.y+2, inventoryText.width, inventoryText.height);
			addChild(inventoryTitle);	
			inventoryTitle.defaultTextFormat = formatText;
			inventoryTitle.text = 'INVENTORY:';
			
			sheetTitle = Utils.createTextField(sheetText.x+23, sheetText.y+2, sheetText.width, sheetText.height);
			addChild(sheetTitle);	
			sheetTitle.defaultTextFormat = formatText;
			sheetTitle.text = 'SHEET:';
			
			
			outputScroll.direction = "vertical"; 
			outputScroll.setSize(15, textOutput.height+2);  
			outputScroll.move(textOutput.x + textOutput.width-14,textOutput.y-1); 
			addChild(outputScroll); 
			
			focusManager = new FocusManager(this);
			focusManager.setFocus(userInputField);
			
			intro = new Intro();
			addChild(intro);
			
			setUIColor(0xffffff);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			stage.addEventListener(OutputEvent.OUTPUT, outputHandler);
			intro.addEventListener(IntroEvent.STARTGAME, startGameProper);
			intro.addEventListener(IntroEvent.LOADGAME, loadGameData);
			
			intro.introText();		
		}
		
		
		private function startGameProper(e:IntroEvent):void
		{			
			this.user = e.value;
			createParser();
			
			parse.parseCommand("look");
			
			updateCharacterHandler();
		}
		
		private function loadGameData(e:IntroEvent):void
		{
			this.user = saveHandler.getUser();
			createParser(saveHandler.getRoom());
			
			parse.roomHandler.gettableHandler.gettableArray = saveHandler.getItems();
			parse.roomHandler.personHandler.personArray = saveHandler.getNpcs();
			
			parse.parseCommand("look");
			saveHandler.saveGame(parse);
			
			updateCharacterHandler();
		}	
		
		private function createParser(startRoom:String = 'objects.rooms.house::Bedroom'):void
		{
			parse = new TextParser(startRoom);
			parse.addEventListener(ParserEvent.COLOUR, changeColour);
			parse.addEventListener(ParserEvent.SHEET, updateCharacterHandler);
			parse.addEventListener(ParserEvent.INVENTORY, updateCharacterHandler);
			
			parse.roomHandler.user = this.user;
			parse.sheet.user = this.user;
			addChild(parse);
			
			removeChild(intro);
			intro.isIntroRunning = false;
		}
		
		private function outputHandler(e:OutputEvent):void
		{
			textOutput.text.htmlText += "<div><span class='main'>\n" + e.value + "</span></div>";  // Using div tags allows the truncate function to remove specific blocks of text.
			// Truncate the text field if it is too long (to save memory)
			if (textOutput.text.numLines > maxTextLines)
				truncateOutput(textOutput.text.numLines, maxTextLines); 
			
			textOutput.text.addEventListener(Event.SCROLL, scrollOutputText);
		}
		
		private function truncateOutput(textLines:int, targetLines:int):void
		{
			var str:String = textOutput.text.htmlText;
			
			var minCharacterIndex:int = textOutput.text.getLineOffset(textLines - targetLines);
			var maxCharacterIndex:int = textOutput.text.htmlText.length;
			var offsetIndex:int = str.indexOf("</div>", minCharacterIndex) + 6;   // Using htmlText, we have to remove the excess text in chunks of divs, as set by the outputHandler. 
			textOutput.text.htmlText = str.substr(offsetIndex, maxCharacterIndex); 
		}
		
		private function detectKey(event:KeyboardEvent):void
		{
			if (focusManager.getFocus() != userInputField) // Do not execute key commands unless user input is selected
				return;
			
			switch(event.keyCode)
			{
				case 13:
					handleCommandStack(userInputField.text);
					textOutput.text.htmlText += "<div><span class='main'>\n>" + userInputField.text + "</span></div>";
					
					if (intro.isIntroRunning)
						intro.parseIntroText(userInputField.text);
					else
						parse.parseCommand(userInputField.text);   // Pass the user's input to the textParser to look for commands
					
					userInputField.text = "";
					textOutput.text.scrollV = textOutput.text.bottomScrollV;// Scroll to the bottom of the text field
					outputScroll.scrollTarget = textOutput.text; 
					break;
				case 38:
					if (commandStackCounter > 0)
					{
						commandStackCounter--;
						if(pastCommand2[commandStackCounter] != null)
							userInputField.text = pastCommand2[commandStackCounter];
					}
					break;
				case 40:
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
					break;
				default:
					null;
			}
		}
		
		private function handleCommandStack(newCommand:String):void
		{
			pastCommand2.push(newCommand);
			
			if (pastCommand2.length > 10)
				pastCommand2.shift();
			
			commandStackCounter = pastCommand2.length;
		}
		
		private function changeColour(e:ParserEvent):void
		{
			if (e.value == "black")
				setUIColor(0x000000);
			else
				setUIColor(0xffffff);
		}
		
		private function setUIColor(txtColour:uint):void
		{
			if (txtColour == 0x000000)
			{
				outputCSS.parseCSS(blackText);
				textOutput.setContainerBlack();
				textInput.setContainerBlack();
				sheetText.setContainerBlack();
				inventoryText.setContainerBlack();
			}
			else
			{
				outputCSS.parseCSS(whiteText);
				textOutput.setContainerWhite();
				textInput.setContainerWhite();
				sheetText.setContainerWhite();
				inventoryText.setContainerWhite();
			}
			
			formatText.color = txtColour;
			
			userInputField.defaultTextFormat = formatText;
			inventoryTitle.textColor = txtColour;
			sheetTitle.textColor = txtColour;
			
			textOutput.text.styleSheet = outputCSS;
			sheetText.text.styleSheet = outputCSS;
			inventoryText.text.styleSheet = outputCSS;
		}
		
		private function updateCharacterHandler(e:ParserEvent=null):void
		{			
			if (parse != null)
			{
				inventoryText.text.htmlText = "<div><span class='main'>"+parse.roomHandler.gettableHandler.currentInventory()+"</span></div>"; 
				sheetText.text.htmlText = "<div><span class='main'>"+parse.sheet.getSheet()+"</span></div>"; 
			}
		}
		
		private function scrollOutputText(event:Event):void
		{
			textOutput.text.scrollV = textOutput.text.maxScrollV;	
			outputScroll.scrollTarget = textOutput.text;	
			
			textOutput.text.removeEventListener(Event.SCROLL, scrollOutputText);
		}
	}

}