package starling.extensions.krecha {
	import starling.display.Shape;

	public class ElipseShape extends Shape
	{
		private var _radius:Number;

		public function ElipseShape(width:Number, height:Number)
		{
			super();
			_radius = width;
			graphics.beginFill(0x0);
			graphics.drawEllipse(0,0,width, height);
			graphics.endFill();
		}

//		public function get radius():Number
//		{
//			return _radius;
//		}
//
//		public function set radius(value:Number):void
//		{
//			_radius = value;
//		}
	}
}
