/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.ui.controls.TargetItem;

	import robotlegs.starling.bundles.mvcs.Mediator;

	import starling.events.Event;

	public class GameViewMediator extends Mediator
	{
		[Inject]
		public var view:GameView;

		private var _targets:Vector.<TargetItem>;
		private var _selectedTargetId:int;
		public function GameViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			view.createField(10,10);

			_targets = view.createTargets(3);
			for(var i:int = 0; i<_targets.length; i++)
			{
				_targets[i].addEventListener(Event.TRIGGERED, onSelectTarget)
			}

			view.onGameOverSignal.add(onGameOverHandler);
		}

		private function onSelectTarget(evt:Event):void
		{
			var selectedItem:TargetItem = _targets[_targets.indexOf(evt.currentTarget)];
			_selectedTargetId = selectedItem.id;
			view.startGame();
		}

		private function onGameOverHandler(targetId:int):void
		{
			if(targetId == _selectedTargetId)
			{
				trace("You Win");
			}
			else
			{
				trace("You Lost");
			}
			view.resetPositions();
		}
	}
}
