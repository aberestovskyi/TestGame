package starling.extensions.pixelmask {
	import com.framework.ui.AssetProxyContainer;

	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Matrix;

	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.textures.RenderTexture;

	/** HOWTO:
		// myCustomDisplayObject and myCustomMaskDisplayObject can be any Starling display object:
		var myCustomDisplayObject:Sprite = new Sprite();
		var myCustomMaskDisplayObject:Sprite = new Sprite();
		 
		// for masks with animation:
		var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
		maskedDisplayObject.addChild(myCustomDisplayObject);
		 
		// for masks with no animation (note, MUCH better performance!)
		var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject(-1, false);
		maskedDisplayObject.addChild(myCustomDisplayObject);
		 
		// Apply the masking as you would in classic flash.display style.
		// Note: the mask display object should not be added to the display list.
		 
		maskedDisplayObject.mask = myCustomMaskDisplayObject;
		addChild(maskedDisplayObject);
	 */
	public class PixelMaskDisplayObject extends AssetProxyContainer
	{
		private static const MASK_MODE_NORMAL:String = "mask";
		private static const MASK_MODE_INVERTED:String = "maskinverted";
		
		private var _mask:DisplayObject;
		private var _renderTexture:RenderTexture;
		private var _maskRenderTexture:RenderTexture;
		
		private var _image:Image;
		private var _maskImage:Image;
		
		private var _superRenderFlag:Boolean = false;
		private var _inverted:Boolean = false;
		private var _setScaleFactor:Number;
		private var _isAnimated:Boolean = true;
		private var _maskRendered:Boolean = false;
		
		public function PixelMaskDisplayObject(setScaleFactor:Number=-1, isAnimated:Boolean=true)
		{
			super();			
			
			_isAnimated = isAnimated;
			_setScaleFactor = setScaleFactor;
			
			BlendMode.register(MASK_MODE_NORMAL, Context3DBlendFactor.ZERO, Context3DBlendFactor.SOURCE_ALPHA);
			BlendMode.register(MASK_MODE_INVERTED, Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			
			// Handle lost context. By using the conventional event, we can make a weak listener.  
			// This avoids memory leaks when people forget to call "dispose" on the object.
			Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE, 
				onContextCreated, false, 0, true);
		}
		
		override public function linkDisplayByXML(data : XML, container : DisplayObjectContainer = null) : void 
		{
			super.linkDisplayByXML(data, container);
			var shape:Shape;
			if(data["CircleMask"] != undefined)
			{
				shape = new Shape();
				shape.graphics.beginFill(0x000000);
				shape.graphics.drawCircle(0, 0, setScaleFactor(data["CircleMask"].@radius));
				shape.graphics.endFill();
				shape.pivotX -= shape.width * .5;
				shape.pivotY -= shape.height * .5;
				
				if(data["CircleMask"]["Align"].@horizontal=="center")
					shape.x = (totalWidth - shape.width)*.5;
					
				if(data["CircleMask"]["Margin"].@top!=undefined)	
					shape.y+=setScaleFactor(data["CircleMask"]["Margin"].@top);
					
				if(data["CircleMask"]["Margin"].@left!=undefined)	
					shape.x+=setScaleFactor(data["CircleMask"]["Margin"].@left);
					
				if(data.@debug == "true")
				{
					shape.alpha = 0.5;
					addChild(shape);			
				}
				else
				{
					mask = shape;
				}
				
			}
			else if (data["RoundRectMask"] != undefined)
			{
				shape = new Shape();
				shape.graphics.beginFill(0x000000);
				shape.graphics.drawRoundRect(0, 0, setScaleFactor(data["RoundRectMask"].@width), setScaleFactor(data["RoundRectMask"].@height), setScaleFactor(data["RoundRectMask"].@radius));
				shape.graphics.endFill();

				if(data.@debug == "true")
				{
					shape.alpha = 0.5;
					addChild(shape);
				}
				else
				{
					mask = shape;
				}
			}
		}
		
		public function get isAnimated():Boolean
		{
			return _isAnimated;
		}

		public function set isAnimated(value:Boolean):void
		{
			_isAnimated = value;
		}

		override public function dispose():void
		{
			clearRenderTextures();
			Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			super.dispose();
		}
		
		private function onContextCreated(event:Object):void
		{
			refreshRenderTextures();
		}

		public function get inverted():Boolean
		{
			return _inverted;
		}

		public function set inverted(value:Boolean):void
		{
			_inverted = value;
			refreshRenderTextures();
		}

		/*public function set mask(mask:DisplayObject) : void
		{
			// clean up existing mask if there is one
			if (_mask)
				_mask = null;
			
			if (mask)
			{
				_mask = mask;				
				
				if (_mask.width==0 || _mask.height==0)
					throw new Error ("Mask must have dimensions. Current dimensions are " + _mask.width + "x" + _mask.height + ".");
				
				refreshRenderTextures();
			}
			else
				clearRenderTextures();
		}*/
		
		private function clearRenderTextures() : void
		{
			// clean up old render textures and images
			if (_maskRenderTexture)
				_maskRenderTexture.dispose();
			
			if (_renderTexture)
				_renderTexture.dispose();
			
			if (_image)
				_image.dispose();
			
			if (_maskImage)
				_maskImage.dispose();
				
			_maskRendered = false;
		}
		
		private function refreshRenderTextures() : void
		{
			if (_mask) {
				
				clearRenderTextures();
				
				_maskRenderTexture = new RenderTexture(_mask.width, _mask.height, false, _setScaleFactor);
				_renderTexture = new RenderTexture(_mask.width, _mask.height, false, _setScaleFactor);
				
				// create image with the new render texture
				_image = new Image(_renderTexture);
				
				// create image to blit the mask onto
				_maskImage = new Image(_maskRenderTexture);
			
				// set the blending mode to MASK (ZERO, SRC_ALPHA)
				if (_inverted)
					_maskImage.blendMode = MASK_MODE_INVERTED;
				else
					_maskImage.blendMode = MASK_MODE_NORMAL;
			}
			//_maskRendered = false;
		}
		
		public override function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_isAnimated || (!_isAnimated && !_maskRendered))
			{
				if (_superRenderFlag || !_mask)
				{
					super.render(support, parentAlpha);
				}
				else
				{			
					if (_mask)
					{					 
						_maskRenderTexture.draw(_mask);
						_renderTexture.drawBundled(drawRenderTextures);				
						_image.render(support, parentAlpha);
						_maskRendered = true;
					}
				}
			}
			else
			{
				_image.render(support, parentAlpha);
			}
		}
		
		private function drawRenderTextures() : void
		{
			// undo scaling and positioning temporarily because its already applied in this execution stack
			
			var matrix:Matrix = this.transformationMatrix.clone();
			
			this.transformationMatrix = new Matrix();
			_superRenderFlag = true;			
			_renderTexture.draw(this);
			_superRenderFlag = false;
			
			this.transformationMatrix = matrix;
			_renderTexture.draw(_maskImage);
		}
		

		/*public function get mask():DisplayObject
		{
			return _mask;
		}*/
	}
}