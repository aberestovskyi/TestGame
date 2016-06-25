package starling.animation {
	import starling.utils.Color;

	public class ColorTween extends Tween
	{
		private var _color:uint;

		private var _oldRGB:RGB;
		private var _targetRGB:RGB;

		private var _actualTarget:Object;

		public function ColorTween(target:Object, time:Number, transition:Object = "linear")
		{
			_color = color;
			_actualTarget = target;
			_oldRGB = new RGB();
			_targetRGB = new RGB();

			super(_oldRGB, time, transition);
		}


		override public function advanceTime(time:Number):void
		{
			super.advanceTime(time);

			_actualTarget.color = _oldRGB.Hex;
		}

		override public function reset(target:Object, time:Number, transition:Object = "linear"):Tween
		{
			_oldRGB.Red = Color.getRed(_actualTarget.color);
			_oldRGB.Green = Color.getGreen(_actualTarget.color);
			_oldRGB.Blue = Color.getBlue(_actualTarget.color) ;
			return super.reset(_oldRGB, time, transition);
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;

			_targetRGB.Red = Color.getRed(_color);
			_targetRGB.Green = Color.getGreen(_color);
			_targetRGB.Blue = Color.getBlue(_color);

			animate("Red", _targetRGB.Red);
			animate("Green", _targetRGB.Green);
			animate("Blue", _targetRGB.Blue);
		}
	}
}
