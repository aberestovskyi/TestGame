/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.controls
{
	import com.pinball.managers.AppManager;

	import flash.geom.Rectangle;

	import starling.display.Button;
	import starling.display.Sprite;

	public class TargetItem extends Sprite
	{
		private var _itemBounds:Rectangle;
		private var _id:int;

		private var _button:Button;
		public function TargetItem(id:int, width:Number, height:Number)
		{
			super();
			_id = id;
			_itemBounds = new Rectangle(0,0,width, height);

			_button = new Button(AppManager.getInstance().assetManager.getTexture("target_btn"));
			_button.x = (width - _button.width) *.5;
			_button.y = (height - _button.height) *.5;
			addChild(_button);
		}

		public function get id():int
		{
			return _id;
		}

		public function get itemBounds():Rectangle
		{
			_itemBounds.x = x;
			_itemBounds.y = y;
			return _itemBounds;
		}
	}
}
