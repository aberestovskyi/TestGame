/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.controls
{
	import flash.geom.Rectangle;

	import starling.display.Shape;
	import starling.display.Sprite;

	public class TargetItem extends Sprite
	{
		private var _itemBounds:Rectangle;
		private var _id:int;
		public function TargetItem(id:int, width:Number, height:Number)
		{
			super();
			_id = id;
			_itemBounds = new Rectangle(0,0,width, height);
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x00FF00);
			shape.graphics.drawRect(0,0,width,height);
			shape.graphics.endFill();
			addChild(shape);
		}

		public function get itemBounds():Rectangle
		{
			_itemBounds.x = x;
			_itemBounds.y = y;
			return _itemBounds;
		}

		public function get id():int
		{
			return _id;
		}
	}
}