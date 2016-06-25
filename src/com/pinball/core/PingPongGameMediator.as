/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.core
{
	import com.pinball.events.GameEvent;

	import robotlegs.starling.bundles.mvcs.Mediator;

	public class PingPongGameMediator extends Mediator
	{
		[Inject]
		public var view:PingPongGameCore;

		public function PingPongGameMediator()
		{
			super();
		}

		override public function initialize():void
		{
			dispatch(new GameEvent(GameEvent.STARTUP, view));
		}
	}
}
