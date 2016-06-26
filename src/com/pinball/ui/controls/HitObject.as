/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.controls
{
	import com.pinball.interfaces.IHitObject;
	import com.pinball.managers.AppManager;

	import starling.display.Image;
	import starling.display.Sprite;

	public class HitObject extends Sprite implements IHitObject
	{
		private var _radius:Number;
		public function HitObject(radius:Number)
		{
			super();

			_radius = radius;
			var image:Image = new Image(AppManager.getInstance().assetManager.getTexture("hit_point"));
			addChild(image);
		}

		public function get radius():Number
		{
			return _radius;
		}

	}
}
