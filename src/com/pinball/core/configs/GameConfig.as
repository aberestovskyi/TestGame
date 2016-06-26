/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.core.configs
{
	import com.pinball.controller.StartupAppCommand;
	import com.pinball.core.PingPongGameCore;
	import com.pinball.core.PingPongGameMediator;
	import com.pinball.data.PlayerModel;
	import com.pinball.events.GameEvent;
	import com.pinball.ui.view.AbstractView;
	import com.pinball.ui.view.game.GameView;
	import com.pinball.ui.view.game.GameViewMediator;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.starling.extensions.contextView.ContextView;
	import robotlegs.starling.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.starling.extensions.viewProcessorMap.api.IViewProcessorMap;

	public class GameConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var commandMap:IEventCommandMap;

		[Inject]
		public var contextView:ContextView;

		[Inject]
		public var views:IViewProcessorMap;

		public function GameConfig()
		{
		}

		public function configure():void
		{
			views.mapMatcher(new TypeMatcher().allOf(AbstractView)).toInjection();

			//map commands
			commandMap.map(GameEvent.STARTUP, GameEvent).toCommand(StartupAppCommand).once();

			//map views
			mediatorMap.map(PingPongGameCore).toMediator(PingPongGameMediator);
			mediatorMap.map(GameView).toMediator(GameViewMediator);

			//map models
			injector.map(PlayerModel).asSingleton();


		}
	}
}
