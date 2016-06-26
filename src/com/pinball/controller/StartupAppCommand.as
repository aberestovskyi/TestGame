/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.controller
{
	import com.pinball.core.AppManager;
	import com.pinball.embed.EmbeddedAssets;
	import com.pinball.events.GameEvent;
	import com.pinball.ui.view.game.GameView;

	import robotlegs.bender.bundles.mvcs.Command;

	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class StartupAppCommand extends Command
	{
		[Inject]
		public var event:GameEvent;

		private var _assetManager:AssetManager;
		public function StartupAppCommand()
		{
			super();
		}


		override public function execute() : void
		{
			super.execute();

			_assetManager = AppManager.getInstance().assetManager;
			_assetManager.enqueue(EmbeddedAssets);
			_assetManager.loadQueue(onLoadAssetsProgress);
		}

		private function onLoadAssetsProgress(progress:Number):void
		{
			if(progress == 1)
			{
				var core:Sprite = event.data as Sprite;
				var view:GameView = new GameView();
				core.addChild(view);
			}
		}
	}
}
