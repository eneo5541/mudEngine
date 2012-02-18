package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import handler.RoomHandler;
	import objects.house.BedRoom;
	import parser.LookEvent;
	import parser.TextParser;
	

	public class Main extends Sprite 
	{
		private var userInputField:TextField = new TextField(); 
		private var userOutputField:TextField = new TextField();
		private var userInputString:String;
		private var parse:TextParser;
		
		public function Main():void 
		{						
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.graphics.beginFill(0xFFCC00);
            this.graphics.drawRect(0, 0, 400, 300);
            this.graphics.endFill();
			
			parse = new TextParser;
			
			userInputField.type = TextFieldType.INPUT;
			userInputField.x = 0; 
			userInputField.y = 270;
            userInputField.width = 400; userInputField.height = 30;
			userInputField.border = true;
			userInputField.borderColor = 0xff0000;
			userInputField.text = "";
			addChild(userInputField); 
			
			userOutputField = new TextField();
			userOutputField.multiline = true;
			userOutputField.x = 0; 
			userOutputField.y = 00;
            userOutputField.width = 400; userOutputField.height =270;
			userOutputField.border = true;
			userOutputField.borderColor = 0x0000ff;
			userOutputField.text = "";
			this.addChild(userOutputField);
			
			var str:String = parse.parseCommand("look");
			userOutputField.appendText(str);
			
			userInputField.addEventListener(Event.CHANGE, inputEventCapture);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			//parse.addEventListener(LookEvent.LOOK, lookHandler);
		}
		
		private function inputEventCapture(event:Event):void
		{
			userInputString = userInputField.text; 
		}
		
		private function detectKey(event:KeyboardEvent):void
		{
			if (event.keyCode == 13)
			{
				var str:String = parse.parseCommand(userInputString);
				userOutputField.appendText(str);
				userInputString = "";
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