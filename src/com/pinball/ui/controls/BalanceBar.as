/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.controls
{
	import com.pinball.managers.AppManager;

	import flash.filters.GlowFilter;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class BalanceBar extends Sprite
	{
		private var _balance_txt:TextField;
		public function BalanceBar()
		{
			super();
			_balance_txt = new TextField(100,50, "0", "Berlin Sans", 30, 0xFFFFFF);
			_balance_txt.hAlign = HAlign.LEFT;
			_balance_txt.nativeFilters = [new GlowFilter(0x000, 1, 3,3,20, 3)];
			_balance_txt.x = 60;
			_balance_txt.y = 10;
			addChild(_balance_txt);

			var icon:Image = new Image(AppManager.getInstance().assetManager.getTexture("apple-big"));
			addChild(icon);
		}

		public function set balance(value:Number):void
		{
			_balance_txt.text = String(value);
		}
	}
}
