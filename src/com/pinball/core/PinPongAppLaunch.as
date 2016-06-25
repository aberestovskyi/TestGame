/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.core
{
	import com.pinball.core.configs.GameConfig;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;

	import robotlegs.bender.framework.impl.Context;
	import robotlegs.starling.bundles.mvcs.StarlingBundle;
	import robotlegs.starling.extensions.contextView.ContextView;
	import robotlegs.starling.extensions.viewProcessorMap.ViewProcessorMapExtension;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	[SWF(backgroundColor="#ffffff", frameRate="30", width="800", height="600")]
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

			var stageWidth:Number = int(stage.stageWidth);
			var stageHeight:Number = int(stage.stageHeight);

			var viewPort:Rectangle = RectangleUtil.fit(
					new Rectangle(0, 0, stageWidth, stageHeight),
					new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
					ScaleMode.SHOW_ALL, false);

			_starling = new Starling(PingPongGameCore, stage, viewPort, null, "auto", "auto");
			_starling.stage.stageWidth  = stageWidth;
			_starling.stage.stageHeight = stageHeight;
			_starling.enableErrorChecking = false;
			_starling.simulateMultitouch = false;
			_starling.showStats = true;

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
