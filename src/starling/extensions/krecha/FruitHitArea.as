package starling.extensions.krecha {
	import com.framework.interfaces.IDestroyable;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.display.DisplayObject;
	import starling.display.Shape;

	public class FruitHitArea implements IDestroyable
	{
		public static const HELPER_ZERO_POINT:Point = new Point();
		public static const HELPER_RECT:Rectangle = new Rectangle();

		public var target:DisplayObject;
		public var customShape:Shape;

		private var _xOffset:Number;
		private var _yOffset:Number;

		public function FruitHitArea(target:DisplayObject, customShape:Shape = null, xOffset:Number = 0, yOffset:Number = 0)
		{
			this.target = target;
			this.customShape = customShape;
			_xOffset =  xOffset;
			_yOffset =  yOffset;
		}

		public function contains(x:Number, y:Number):Boolean
		{
			var object:DisplayObject = activeObject;
			HELPER_RECT.setTo(globalX + _xOffset, globalY + _yOffset, object.width, object.height);
			if (object is ElipseShape)
			{
				HELPER_RECT.x -= object.width*0.5;
				HELPER_RECT.y -= object.height*0.5;
			}
			else if (object is CircleShape)
			{
				var radius:Number = CircleShape(object).radius;
				var mx:Number = HELPER_RECT.x;
				var my:Number = HELPER_RECT.y;
//				var cx:Number = HELPER_RECT.x + radius;
//				var cy:Number = HELPER_RECT.y + radius;
				var d:Number = Math.sqrt( Math.pow(x - mx, 2) + Math.pow(y - my, 2) );
				return (d < radius);
			}
			return HELPER_RECT.contains(x, y);
		}

		public function get activeObject():DisplayObject
		{
			return (customShape) ? customShape : target;
		}

		public function get globalX():Number
		{
			return target.localToGlobal(HELPER_ZERO_POINT).x;
		}

		public function get globalY():Number
		{
			return target.localToGlobal(HELPER_ZERO_POINT).y;
		}

		public function get xOffset():Number
		{
			return _xOffset;
		}

		public function get yOffset():Number
		{
			return _yOffset;
		}

		public function destroy():void
		{
			target = null;
			if (customShape)
			{
				customShape.removeFromParent(true);
			}

		}

		public function set xOffset(value:Number):void
		{
			_xOffset = value;
		}

		public function set yOffset(value:Number):void
		{
			_yOffset = value;
		}
	}
}
