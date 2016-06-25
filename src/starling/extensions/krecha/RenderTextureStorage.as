package starling.extensions.krecha
{
	import starling.textures.RenderTexture;

	public class RenderTextureStorage
	{
		private static var _items:Array = [];

		public static function getItem(width:Number, height:Number):RenderTexture
		{
			var length:int = _items.length;
			for (var index:int = length - 1; index >= 0 ; index--)
			{
				var tex:RenderTexture = _items[index];
				if (tex.width == width && tex.height == height)
				{
					return _items.splice(index, 1)[0];
				}
				else
				{
					destoryItem(tex);
				}
			}

			return null;
		}

		public static function destoryItem(tex:RenderTexture):void
		{
			destroyItemAt(_items.indexOf(tex));
		}

		private static function destroyItemAt(index:int):void
		{
			var tex:RenderTexture = _items.splice(index, 1)[0];
			tex.dispose();
		}

		public static function free(tex:RenderTexture):void
		{
			_items.push(tex);
		}

		public static function destroyAll():void
		{
			var length:int = _items.length;
			for (var index:int = length - 1; index >= 0 ; index--)
			{
				destroyItemAt(index);
			}
		}
	}
}
