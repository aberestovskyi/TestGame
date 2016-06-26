/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.controls
{
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.utils.deg2rad;

	public class Ball extends Sprite implements IAnimatable
	{
		private var _maxSpeed:Number;
		private var _radius:Number;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		public function Ball(radius:Number)
		{
			super();

			_radius = radius;
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawCircle(0,0,radius);
			shape.graphics.endFill();
			addChild(shape);
		}

		public function setVelocity(speed:Number, angle:Number):void
		{
			_maxSpeed = speed;
			_vx = speed*Math.cos(deg2rad(angle));
			_vy = speed*Math.sin(deg2rad(angle));
		}

		public function advanceTime(time:Number):void
		{
			_vy+=0.8;

			var time1:Number = time / (Starling.current.nativeStage.frameRate / 1000);
			var xx:Number = x + _vx * time1;
			var yy:Number = y + _vy * time1;

			x = xx;
			y = yy;
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function get vx():Number
		{
			return _vx;
		}

		public function get vy():Number
		{
			return _vy;
		}

		public function set vx(value:Number):void
		{
			_vx = value;
		}

		public function set vy(value:Number):void
		{
			_vy = value;
		}
	}
}
