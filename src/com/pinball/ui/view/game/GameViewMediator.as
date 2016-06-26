/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.data.PlayerModel;
	import com.pinball.ui.controls.TargetItem;
	import com.pinball.ui.view.result.ResultMessage;
	import com.pinball.utils.TimeoutUtils;

	import robotlegs.starling.bundles.mvcs.Mediator;

	import starling.events.Event;

	public class GameViewMediator extends Mediator
	{
		[Inject]
		public var view:GameView;

		[Inject]
		public var playerModel:PlayerModel;

		private var _targets:Vector.<TargetItem>;

		public function GameViewMediator()
		{
			super();
		}


		override public function initialize():void
		{
			super.initialize();

			playerModel.balance = 100;
			playerModel.bet = 1;
			view.createField(10,10);

			_targets = view.createTargets(3);
			for(var i:int = 0; i<_targets.length; i++)
			{
				_targets[i].addEventListener(Event.TRIGGERED, onSelectTarget)
			}

			view.setBalance(playerModel.balance);
			view.resetGame();
			view.onGameOverSignal.add(onGameOverHandler);
		}

		private function onSelectTarget(evt:Event):void
		{
			playerModel.balance-=playerModel.bet;

			var selectedItem:TargetItem = _targets[_targets.indexOf(evt.currentTarget)];
			view.setSelectedItem(selectedItem.id);
			TimeoutUtils.addTimeout(view.startGame, 500);
		}

		private function onGameOverHandler(isWin:Boolean):void
		{
			var resultMessage:ResultMessage = new ResultMessage(isWin);
			resultMessage.onOutComplete.addOnce(resetGame);
			view.addChild(resultMessage);

			if(isWin)
				playerModel.balance+=playerModel.bet*2;

			view.setBalance(playerModel.balance);
		}

		private function resetGame():void
		{
			view.resetGame();
		}
	}
}
