package starling.extensions.krecha {
	import com.framework.interfaces.IDisplayObjectDestroyable;
	import com.framework.interfaces.IResizable;
	import com.fruitcrush.data.statics.TextureStatics;

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;

	public class FruitImageTouch extends Image implements IResizable, IDisplayObjectDestroyable
	{
		public static const HELPER_POINT:Point = new Point();

		private var _hitAreaObjects:Vector.<FruitHitArea> = new Vector.<FruitHitArea>();
		private var _frame:Rectangle = new Rectangle();
		private var _autoDestroy:Boolean = true;
		private var _widthIndex:int;
		private var _back:Quad;

		private var _screenWidth:Number = -1;
		private var _screenHeight:Number = -1;

		public function FruitImageTouch(alpha:Number = 0.75, widthIndex:int = 0)
		{
			super(new RenderTexture(1, 1));

			this.alpha = alpha;
			_widthIndex = widthIndex;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			smoothing = TextureSmoothing.TRILINEAR;

			_back = new Quad(1, 1, 0x0);
			_back.blendMode = BlendMode.NORMAL;
		}

		protected function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);

		}

		protected function onRemoveFromStage():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			if (autoDestroy)
			{
				destroy();
			}
		}


		public function addHitArea(object:FruitHitArea):void
		{
			if (_hitAreaObjects.indexOf(object) >= 0)
				return;
			_hitAreaObjects.push(object);
		}

		private function redrawHitArea(object:FruitHitArea):void
		{
			var oldBlendMode:String = object.activeObject.blendMode;
			object.activeObject.blendMode = BlendMode.ERASE;
//			trace("globalX", object.globalX, " globalY", object.globalY);
			var globalX:Number = object.globalX - _widthIndex * TextureStatics.MAX_TEXTURE_SIZE;
			renderTexture.draw(object.activeObject, new Matrix(1, 0, 0, 1, globalX + object.xOffset, object.globalY + object.yOffset));
			object.activeObject.blendMode = oldBlendMode;
		}

		private function redrawAllHitAreas():void
		{
			renderTexture.draw(_back);

			var object:FruitHitArea;
			for each (object in _hitAreaObjects)
			{
				redrawHitArea(object);
			}
		}

		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
		{
//			trace(this, localPoint);

			if (_hitAreaObjects.length > 0)
			{
				if ( frame.containsPoint(localPoint) )
				{
					return isPointOnHitArea(localPoint) ? null : this;
				}
				else
				{
					return null;
				}
			}
			else
			{
				return super.hitTest(localPoint, forTouch);
			}
		}

		private function isPointOnHitArea(localPoint:Point):Boolean
		{
			var object:FruitHitArea;
			var globalX:Number;
			for each (object in _hitAreaObjects)
			{
				globalX = _widthIndex * TextureStatics.MAX_TEXTURE_SIZE;
				if (object.contains(globalX + localPoint.x, localPoint.y))
					return true;
			}
			return false;
		}

		private function get frame():Rectangle
		{
			_frame.setTo(0, 0, texture.width, texture.height);
			return _frame;
		}

		private function get renderTexture():RenderTexture
		{
			return RenderTexture(texture);
		}

		private function set renderTexture(tex:RenderTexture):void
		{
			texture = tex;
		}

		public function resize(fullWidth:Number, fullHeight:Number):void
		{
//			trace("FruitImageTouch.resize", fullWidth ,"x", fullHeight, "images ", _hitAreaObjects.length);

			var oldScreenWidth:Number = _screenWidth;
			var oldScreenHeight:Number = _screenHeight;
			if (fullWidth != oldScreenWidth || fullHeight != oldScreenHeight)
			{
				_back.width = fullWidth;
				_back.height = fullHeight;
//				var oldTime:int = getTimer();
				var rTexture:RenderTexture = RenderTextureStorage.getItem(fullWidth, fullHeight);
				if (!rTexture)
					rTexture = new RenderTexture(fullWidth, fullHeight);
				renderTexture = rTexture;
//				trace("texture create time =", getTimer() - oldTime);

				readjustSize();
			}
			renderTexture.clear();
			renderTexture.drawBundled(redrawAllHitAreas);

			_screenWidth = fullWidth;
			_screenHeight = fullHeight;
		}

		public function clean():void
		{
			while (_hitAreaObjects.shift()) {  }
		}

		public function set autoDestroy(value:Boolean):void
		{
			_autoDestroy = value;
		}

		public function get autoDestroy():Boolean
		{
			return _autoDestroy;
		}

		public function destroy():void
		{
			var object:FruitHitArea;
			while (object = _hitAreaObjects.shift())
			{
				object.destroy();
			}

			RenderTextureStorage.free(renderTexture);

			_back.dispose();

			dispose();
		}
	}
}
