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
			setTimeout(view.start, 1000);
		}
	}
}
