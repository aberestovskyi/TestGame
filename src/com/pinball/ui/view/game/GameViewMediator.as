/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import flash.utils.setTimeout;

	import robotlegs.starling.bundles.mvcs.Mediator;

	public class GameViewMediator extends Mediator
	{
		[Inject]
		public var view:GameView;

		public function GameViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.createField(10,10);
			view.createTargets(3);

			view.onGameOverSignal.add(onGameOverHandler);
			setTimeout(view.startGame, 1000);
		}

		private function onGameOverHandler(targetId:int):void
		{
			view.resetPositions();
			setTimeout(view.startGame, 1000);
		}
	}
}
