/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.controls
{
	import starling.display.Shape;
	import starling.display.Sprite;

	public class HitObject extends Sprite
	{
		private var _radius:Number;
		public function HitObject(radius:Number)
		{
			super();

			_radius = radius;
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawCircle(0,0,_radius);
			shape.graphics.endFill();
			addChild(shape);
		}


		public function get radius():Number
		{
			return _radius;
		}

	}
}
