/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.data.GameStatics;
	import com.pinball.interfaces.IHitObject;
	import com.pinball.managers.AppManager;
	import com.pinball.ui.controls.BalanceBar;
	import com.pinball.ui.controls.Ball;
	import com.pinball.ui.controls.Character;
	import com.pinball.ui.controls.HitObject;
	import com.pinball.ui.controls.TargetItem;
	import com.pinball.ui.view.AbstractView;
	import com.pinball.utils.Vector2dUtils;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.osflash.signals.Signal;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;

	public class GameView extends AbstractView implements IAnimatable
	{
		private var _hitObjects:Vector.<HitObject>;
		private var _targets:Vector.<TargetItem>;
		private var _ball:Ball;
		private var _boundsRect:Rectangle;
		private var _isInField:Boolean;

		private var _onGameOverSignal:Signal = new Signal(Boolean);
		private var _balanceBar:BalanceBar;
		private var _character:Character;
		public function GameView()
		{
			super();

			var back:Image = new Image(AppManager.getInstance().assetManager.getTexture("background_img"));
			addChild(back);

			_character = new Character();
			_character.visible = false;
			addChild(_character);

			_balanceBar = new BalanceBar();
			_balanceBar.x = 30;
			_balanceBar.y = 270;
			addChild(_balanceBar);

			_ball = new Ball(10);
			addChild(_ball);
		}

		public function startGame():void
		{
			_ball.setVelocity(27 + Math.random()*5, -96 - Math.random()*3);
			Starling.juggler.add(this);
			Starling.juggler.add(_ball);
		}

		public function resetGame():void
		{
			Starling.juggler.remove(_ball);
			setSelectedItem(-1);
			_isInField =false;
			_ball.x = _boundsRect.right + 50;
			_ball.y = _boundsRect.bottom - 10;
		}

		private function stopGame(isWin:Boolean):void
		{
			Starling.juggler.remove(this);
			_onGameOverSignal.dispatch(isWin);
		}

		public function createField(rows:int, cols:int):void
		{
			_hitObjects = new Vector.<HitObject>();

			var padding:Number = 35;
			var startX:Number = (GameStatics.GAME_WIDTH - cols * padding)*0.5;
			var startY:Number = 150;
			var hitRadius:Number = 4;
			var hitObject:HitObject;
			_boundsRect = new Rectangle(startX - padding, startY, cols * padding + padding*1.5, rows * padding);

			for(var i:int = 0; i<rows; i++)
			{
				for(var j:int = 0; j<cols; j++)
				{
					hitObject = new HitObject(hitRadius);
					hitObject.x = startX+ j * padding;
					hitObject.y = startY + i * padding;
					if(i%2 == 0)
						hitObject.x+=padding/2;
					addChild(hitObject);
					_hitObjects.push(hitObject);
				}
			}
		}

		public function createTargets(count:int):Vector.<TargetItem>
		{
			_targets = new Vector.<TargetItem>();
			var target:TargetItem;
			var padding:Number = 10;
			var itemWidth:Number = (_boundsRect.width - (padding*(count-1)))/count;
			for(var i:int = 0; i<count; i++)
			{
				target = new TargetItem(i,itemWidth, 100);
				target.x = _boundsRect.x + (itemWidth + padding)*i;
				target.y = _boundsRect.bottom + 30;
				addChild(target);
				_targets.push(target);
			}

			return _targets;
		}

		public function setSelectedItem(selectedItemID:int):void
		{
			if(selectedItemID >= 0)
			{
				var selectedTarget:TargetItem = _targets[selectedItemID];
				_character.hitArea = selectedTarget.itemBounds;
				_character.x = selectedTarget.x + (selectedTarget.itemBounds.width - _character.width)*.5;
				_character.y = selectedTarget.y;
				_character.visible = true;
			}
			else
			{
				_character.changState(0);
				_character.visible = false;
			}


			for(var i:int = 0; i<_targets.length; i++)
			{
				if(selectedItemID == -1)
					_targets[i].visible = true;
				else
					_targets[i].visible = false;
			}
		}

		public function advanceTime(time:Number):void
		{
			for(var i:int = 0; i<_hitObjects.length; i++)
			{
				checkCollision(_hitObjects[i]);
			}

			checkBallForBorders();

			if(_ball.y > _boundsRect.bottom)
			{
				if(_character.hitArea.contains(_ball.x, _ball.y))
				{
					_character.changState(1);
					_ball.setVelocity(10, -85 - Math.random()*10);
					stopGame(true);
				}
				else if(_ball.y > stage.stageHeight)
				{
					stopGame(false);
				}
			}
		}

		private function checkBallForBorders():void
		{
			if(_ball.x - _ball.radius>_boundsRect.left && _ball.x + _ball.radius<_boundsRect.right)
			{
				_isInField = true;
			}

			if(_isInField)
			{
				if(_ball.x + _ball.radius>=_boundsRect.right)
				{
					_ball.x = _boundsRect.right-_ball.radius;
					_ball.vx*=-1;
				}
				else if(_ball.x - _ball.radius<=_boundsRect.x)
				{
					_ball.x = _boundsRect.x + _ball.radius;
					_ball.vx*=-1;
				}
			}
		}

		public function checkCollision(hitObject:IHitObject):Boolean
		{
			var xx:Number = _ball.x - hitObject.x;
			var yy:Number = _ball.y - hitObject.y;
			var distance:Number = Math.sqrt(xx * xx + yy * yy);
			var totalRadius:Number = _ball.radius + hitObject.radius;
			var diff:Number = totalRadius - distance;
			if(diff >= 0)
			{
				var dx:Number = xx/distance;
				var dy:Number = yy/distance;
				_ball.x += diff * dx;
				_ball.y += diff * dy;

				var resultVector:Point = Vector2dUtils.getBounceVector(new Point(_ball.vx, _ball.vy), dy, -dx, dx, dy);
				_ball.vx = resultVector.x/1.3;
				_ball.vy = resultVector.y/1.3;

				return true;
			}

			return false;
		}


		public function get onGameOverSignal():Signal
		{
			return _onGameOverSignal;
		}

		public function setBalance(value:Number):void
		{
			_balanceBar.balance = value;
		}

		override public function destroy():void
		{
			_onGameOverSignal.removeAll();
			super.destroy();
		}



	}
}
