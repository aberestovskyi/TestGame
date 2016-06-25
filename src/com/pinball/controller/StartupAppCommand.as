/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.controller
{
	import com.pinball.events.GameEvent;
	import com.pinball.ui.view.game.GameView;

	import robotlegs.bender.bundles.mvcs.Command;

	import starling.display.Sprite;

	public class StartupAppCommand extends Command
	{
		[Inject]
		public var event:GameEvent;

		public function StartupAppCommand()
		{
			super();
		}


		override public function execute() : void
		{
			super.execute();

			var core:Sprite = event.data as Sprite;
			var view:GameView = new GameView();
			core.addChild(view);
		}


	}
}
