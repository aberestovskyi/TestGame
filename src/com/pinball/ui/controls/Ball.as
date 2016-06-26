/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.controls
{
	import com.pinball.managers.AppManager;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.deg2rad;

	public class Ball extends Sprite implements IAnimatable
	{
		private var _maxSpeed:Number;
		private var _radius:Number;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _image:Image;
		private var _newRotation:Number;
		public function Ball(radius:Number)
		{
			super();

			_radius = radius;
			_image = new Image(AppManager.getInstance().assetManager.getTexture("ball"));
			_image.alignPivot();
			_image.x = _image.pivotX;
			_image.y = _image.pivotY;
			addChild(_image);
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
			_newRotation = Math.atan2(_vy, _vx) - Math.PI/2;;
			_image.rotation += (_newRotation - _image.rotation)/10;
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
