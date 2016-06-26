/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.managers
{
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class AppManager
	{
		private static var _instance:AppManager;
		private var _assetManager:AssetManager;
		private var _viewManager:ViewManager;

		private var _core:Sprite;
		public function AppManager()
		{
			_assetManager = new AssetManager();
			_viewManager = new ViewManager();
		}

		public static function getInstance() : AppManager
		{
			if(!_instance)
				_instance = new AppManager();

			return _instance;
		}

		public function get assetManager() : AssetManager
		{
			return _assetManager;
		}

		public function get viewManager():ViewManager
		{
			return _viewManager;
		}

		public function set core(value:Sprite):void
		{
			_core = value;
		}

		public function get core():Sprite
		{
			return _core;
		}


	}
}
