/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.controls
{
	import starling.display.Shape;
	import starling.display.Sprite;

	public class Ball extends Sprite
	{

		public function Ball(radius:Number)
		{
			super();

			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawCircle(0,0,radius);
			shape.graphics.endFill();
			addChild(shape);
		}
	}
}
