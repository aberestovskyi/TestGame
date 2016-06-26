/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.data.GameStatics;
	import com.pinball.ui.controls.Ball;
	import com.pinball.ui.controls.HitObject;
	import com.pinball.ui.controls.TargetItem;
	import com.pinball.ui.view.AbstractView;
	import com.pinball.utils.Vector2dUtils;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.osflash.signals.Signal;

	import starling.animation.IAnimatable;
	import starling.core.Starling;

	public class GameView extends AbstractView implements IAnimatable
	{
		private var _hitObjects:Vector.<HitObject>;
		private var _targets:Vector.<TargetItem>;
		private var _ball:Ball;
		private var _boundsRect:Rectangle;
		private var _isInField:Boolean;

		private var _onGameOverSignal:Signal = new Signal(int);
		public function GameView()
		{
			super();
		}


		override protected function complete():void
		{
			super.complete();

			_ball = new Ball(10);
			addChild(_ball);
			resetPositions();
		}

		public function startGame():void
		{
			_ball.setVelocity(25 + Math.random()*5, -97 - Math.random()*3);
			Starling.juggler.add(this);
			Starling.juggler.add(_ball);
		}

		public function resetPositions():void
		{
			_isInField =false;
			_ball.x = 640;
			_ball.y = 400;
		}

		public function stopGame(targetId:int):void
		{
			Starling.juggler.remove(this);
			Starling.juggler.remove(_ball);
			_onGameOverSignal.dispatch(targetId);
		}

		public function createField(rows:int, cols:int):void
		{
			_hitObjects = new Vector.<HitObject>();

			var padding:Number = 35;
			var startX:Number = (GameStatics.GAME_WIDTH - cols * padding)*0.5;
			var startY:Number = 100;
			var hitRadius:Number = 4;
			var hitObject:HitObject;
			_boundsRect = new Rectangle(startX - padding, startY, cols * padding + padding*2, rows * padding);

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

		public function createTargets(count:int):void
		{
			_targets = new Vector.<TargetItem>();
			var target:TargetItem;
			var padding:Number = 10;
			var itemWidth:Number = (_boundsRect.width/count) - (padding * (count-1));
			for(var i:int = 0; i<count; i++)
			{
				target = new TargetItem(i,itemWidth, 100);
				target.x = _boundsRect.x + (itemWidth + padding)*i + padding;
				target.y = _boundsRect.bottom;
				addChild(target);
				_targets.push(target);
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
				for(var i:int = 0; i<_targets.length; i++)
				{
					if(_targets[i].itemBounds.contains(_ball.x, _ball.y))
					{
						stopGame(_targets[i].id);
						break;
					}
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

		public function checkCollision(hitObject:HitObject):void
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
			}
		}


		public function get onGameOverSignal():Signal
		{
			return _onGameOverSignal;
		}

		override public function destroy():void
		{
			_onGameOverSignal.removeAll();
			super.destroy();
		}


	}
}
