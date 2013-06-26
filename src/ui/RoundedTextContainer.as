package ui
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.TextField;

	public class RoundedTextContainer extends Sprite
	{
		public var text:TextField;
		
		private var containerBG:Shape;
		private var containerTitle:Shape;
		
		private var newWidth:Number;
		private var newHeight:Number;
		
		public function RoundedTextContainer(newX:Number, newY:Number, newWidth:Number, newHeight:Number, isTitleVertical:Boolean) 
		{
			this.x = newX;
			this.y = newY;
			
			var radius:Number = 10;
			var padding:Number = 6;
			
			containerBG = new Shape();
			containerBG.graphics.beginFill(0xf0f0f0,1);
			if (isTitleVertical)
			{		
				containerBG.graphics.lineTo(newWidth-30-radius,0);
				containerBG.graphics.curveTo(newWidth-30,0,newWidth-30,radius);
				containerBG.graphics.lineTo(newWidth-30,newHeight-radius);
				containerBG.graphics.curveTo(newWidth-30,newHeight,newWidth-30-radius,newHeight);
				containerBG.graphics.lineTo(0,newHeight);
				containerBG.graphics.lineTo(0, 0);
				
				containerBG.x = 30;
				containerBG.y = 0;
			}
			else
			{
				containerBG.graphics.lineTo(newWidth,0);
				containerBG.graphics.lineTo(newWidth,newHeight-30-radius);
				containerBG.graphics.curveTo(newWidth,newHeight-30,newWidth-radius,newHeight-30);
				containerBG.graphics.lineTo(radius, newHeight-30);
				containerBG.graphics.curveTo(0,newHeight-30,0,newHeight-30-radius);
				containerBG.graphics.lineTo(0, radius);
				
				containerBG.x = 0;
				containerBG.y = 30;
			}
			containerBG.graphics.endFill();
			addChild(containerBG);
			
			
			containerTitle = new Shape();
			containerTitle.graphics.beginFill(0xdcdcdc, 1);
			
			if (isTitleVertical)
			{
				containerTitle.graphics.lineTo(40,0);
				containerTitle.graphics.lineTo(40,newHeight);
				containerTitle.graphics.lineTo(radius, newHeight);
				containerTitle.graphics.curveTo(0,newHeight,0,newHeight-radius);
				containerTitle.graphics.lineTo(0, radius);
				containerTitle.graphics.curveTo(0,0,radius,0);
			}
			else
			{
				containerTitle.graphics.lineTo(newWidth-radius,0);
				containerTitle.graphics.curveTo(newWidth,0,newWidth,radius);
				containerTitle.graphics.lineTo(newWidth,35);
				containerTitle.graphics.lineTo(0, 35);
				containerTitle.graphics.lineTo(0, radius);
				containerTitle.graphics.curveTo(0,0,radius,0);
			}
			
			containerTitle.x = 0;
			containerTitle.y = 0;
			containerTitle.graphics.endFill();
			addChild(containerTitle);
			
			
			text = new TextField();
			text.text = "";
			text.multiline = true; 
			text.wordWrap = true;
			text.selectable = true;
			
			if (isTitleVertical)
			{
				text.x = 40 + padding;
				text.y = padding;
				text.width = newWidth - 40 - (padding*2) - 15;
				text.height = newHeight - (padding*2);
			}
			else
			{
				text.x = padding;
				text.y = 35 + padding;
				text.width = newWidth - (padding * 2);
				text.height = newHeight - 35 - (padding*2);
			}
			
			addChild(text);
		}
		
		public function setContainerBlack():void
		{
			var primaryColour:ColorTransform = new ColorTransform();
			primaryColour.color = 0xffffff;
			containerBG.transform.colorTransform = primaryColour;
			
			var secondaryColor:ColorTransform = new ColorTransform();
			secondaryColor.color = 0xebebeb;
			containerTitle.transform.colorTransform = secondaryColor;
		}
		
		public function setContainerWhite():void
		{
			var primaryColour:ColorTransform = new ColorTransform();
			primaryColour.color = 0x0f0f0f;
			containerBG.transform.colorTransform = primaryColour;
			
			var secondaryColor:ColorTransform = new ColorTransform();
			secondaryColor.color = 0x1e1e1e;
			containerTitle.transform.colorTransform = secondaryColor;
		}
	}

}