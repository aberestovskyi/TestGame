package starling.extensions.krecha
{
	import com.framework.ui.AssetProxyContainer;
	import com.fruitcrush.data.statics.TextureStatics;

	import starling.events.Event;

	public class TouchImageContainer extends AssetProxyContainer
	{
		private var _hitAreas:Array = [];
		private var _touchImages:Array = [];

		public function TouchImageContainer()
		{
			super();

			complete();
		}

		override protected function complete():void
		{
//			super.complete();

			var mainImage:FruitImageTouch = generateImage();
			addChild(mainImage);
		}

		private function generateImage(widthIndex:int = 0):FruitImageTouch
		{
			var image:FruitImageTouch = new FruitImageTouch(0.75, widthIndex);
			_touchImages.push(image);
			return image;
		}

		override public function resize(fullWidth:Number, fullHeight:Number):void
		{
			if (_isDestroyed)
				return;

			var image:FruitImageTouch;
			var index:int;
			if (fullWidth >= TextureStatics.MAX_TEXTURE_SIZE)
			{
				if (_touchImages.length == 1)
				{
					image = generateImage(1);
				}
				else
				{
					image = _touchImages[1];
				}
				addChild(image);
				_touchImages[0].clean();
			}
			else
			{
				if (_touchImages.length > 1)
				{
					for (var j:int = 1; j < _touchImages.length; j++)
					{
						image = _touchImages[j];
						image.clean();
						removeChild(image);
						_touchImages.splice(_touchImages.indexOf(j), 1);
					}
				}
			}


			var component:FruitHitArea;
			for (index = 0; index < _hitAreas.length; index++)
			{
				component = _hitAreas[index];
				image = (component.globalX >= TextureStatics.MAX_TEXTURE_SIZE) ? _touchImages[1] : _touchImages[0];
				image.addHitArea(component);
			}

			var prevWidth:Number = 0;
			var newWidth:Number = 0;
			for (index = 0; index < _touchImages.length; index++)
			{
				prevWidth = (index == 0) ? 0 : image.x + image.width;
				image = _touchImages[index];
				if (image.parent == null)
					continue;

				newWidth = calculateWidth(fullWidth, prevWidth);
				image.x = prevWidth;
				image.resize(newWidth, fullHeight);
			}

//			trace("total FIT count", _touchImages.length);
			super.resize(fullWidth, fullHeight);
		}

		private function calculateWidth(fullWidth:Number, prevWidth:Number):Number
		{
			var diff:Number = fullWidth - prevWidth;
			return diff > 0
					? (diff >= TextureStatics.MAX_TEXTURE_SIZE)
						? TextureStatics.MAX_TEXTURE_SIZE
						: diff
					: 0;
		}

		public function addHitArea(object:FruitHitArea):void
		{
			_hitAreas.push(object);
		}

		override public function destroy():void
		{
			var image:FruitImageTouch;
			while(image = _touchImages.shift())
			{
				if (image.parent)
					image.removeFromParent(true);
				else
					image.destroy();
			}

			var hitArea:FruitHitArea;
			while(hitArea = _hitAreas.shift())
			{
				hitArea.destroy();
			}


			super.destroy();
		}
	}
}
