/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.ui.controls.Ball;

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

			var ball:Ball = new Ball(10);
			ball.x = 300;
			ball.y = 20;
			view.addChild(ball);

			view.createField(10,15);
		}
	}
}
