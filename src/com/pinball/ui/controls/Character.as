/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.controls
{
	import com.pinball.managers.AppManager;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.display.Sprite;

	public class Character extends Sprite
	{
		private var _character:Image;
		private var _hitArea:Rectangle;
		public function Character()
		{
			_character = new Image(AppManager.getInstance().assetManager.getTexture("char1"));
			addChild(_character);
		}

		public function changState(state:int):void
		{
			_character.texture = AppManager.getInstance().assetManager.getTexture((state == 0) ? "char1" : "char2");
		}

		public function get hitArea():Rectangle
		{
			return _hitArea;
		}

		public function set hitArea(value:Rectangle):void
		{
			_hitArea = value;
		}
	}
}
