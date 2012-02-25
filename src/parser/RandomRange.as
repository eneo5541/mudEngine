package parser 
{
	public class RandomRange 
	{
		
		public function RandomRange() 
		{
		}
		
		public static function generate(max:Number, min:Number = 0):Number
		{
			 return int(Math.random() * (max - min) + min);
		}
		
	}

}