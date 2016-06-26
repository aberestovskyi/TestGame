/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.core
{
	import com.pinball.core.configs.GameConfig;
	import com.pinball.data.GameStatics;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import robotlegs.bender.framework.impl.Context;
	import robotlegs.starling.bundles.mvcs.StarlingBundle;
	import robotlegs.starling.extensions.contextView.ContextView;
	import robotlegs.starling.extensions.viewProcessorMap.ViewProcessorMapExtension;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.HAlign;

	[SWF(backgroundColor="#ffffff", frameRate="30", width="800", height="700")]
	public class PinPongAppLaunch extends Sprite
	{
		private var _context:Context;
		private var _starling:Starling;
		public function PinPongAppLaunch()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(evt:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			Starling.multitouchEnabled = false;
			Starling.handleLostContext = true;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			GameStatics.GAME_WIDTH = stage.stageWidth;
			GameStatics.GAME_HEIGHT = stage.stageHeight;

			_starling = new Starling(PingPongGameCore, stage);
			_starling.stage.stageWidth  = GameStatics.GAME_WIDTH;
			_starling.stage.stageHeight = GameStatics.GAME_HEIGHT;
			_starling.enableErrorChecking = false;
			_starling.simulateMultitouch = false;
			_starling.showStatsAt(HAlign.RIGHT);

			// this event is dispatched when stage3D is set up
			_starling.addEventListener(Event.ROOT_CREATED, onRootCreated);

			_context = new Context();
			_context.install(StarlingBundle,ViewProcessorMapExtension);
			_context.configure(GameConfig,new ContextView(_starling));
		}


		protected function onRootCreated() : void
		{
			_starling.start();
		}
	}
}
