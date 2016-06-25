package starling.extensions.krecha {
	import starling.display.Shape;

	public class CircleShape extends Shape
	{
		private var _radius:Number;

		public function CircleShape(radiuse:Number)
		{
			super();
			_radius = radiuse;
			graphics.beginFill(0x0);
			graphics.drawCircle(0,0,radius);
			graphics.endFill();
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
		}
	}
}
