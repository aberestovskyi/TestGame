/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.core
{
	import starling.utils.AssetManager;

	public class AppManager
	{
		private static var _instance:AppManager;
		private var _assetManager:AssetManager;

		public function AppManager()
		{
			_assetManager = new AssetManager();
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
	}
}
