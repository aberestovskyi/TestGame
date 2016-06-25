/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.data.GameStatics;
	import com.pinball.ui.controls.Ball;
	import com.pinball.ui.controls.HitObject;
	import com.pinball.ui.view.AbstractView;
	import com.pinball.utils.Vector2dUtils;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.animation.IAnimatable;
	import starling.core.Starling;

	public class GameView extends AbstractView implements IAnimatable
	{
		private var _hitObjects:Vector.<HitObject>;
		private var _ball:Ball;
		private var _boundsRect:Rectangle;
		private var _isInField:Boolean;
		public function GameView()
		{
			super();
		}


		override protected function complete():void
		{
			super.complete();

			_ball = new Ball(10);
			_ball.x = 640;
			_ball.y = 400;
			addChild(_ball);
		}

		public function start():void
		{
			_isInField =false;
			_ball.x = 640;
			_ball.y = 400;
			_ball.setVelocity(25 + Math.random()*5, -97 - Math.random()*3);
			Starling.juggler.add(this);
			Starling.juggler.add(_ball);
		}

		public function createField(rows:int, cols:int):void
		{
			_hitObjects = new Vector.<HitObject>();

			var padding:Number = 35;
			var startX:Number = (GameStatics.GAME_WIDTH - cols * padding)*0.5;
			var startY:Number = 100;
			var hitRadius:Number = 4;
			var hitObject:HitObject;
			_boundsRect = new Rectangle(startX - padding/2, startY, cols * padding + padding/2, rows * padding);
			trace(_boundsRect);
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

		public function advanceTime(time:Number):void
		{
			for(var i:int = 0; i<_hitObjects.length; i++)
			{
				checkCollision(_hitObjects[i]);
			}

			checkBallForBorders();
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
				_ball.vx = resultVector.x/1.5;
				_ball.vy = resultVector.y/1.5;
			}
		}
	}
}
