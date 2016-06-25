/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view.game
{
	import com.pinball.ui.controls.HitObject;
	import com.pinball.ui.view.AbstractView;

	public class GameView extends AbstractView
	{
		public function GameView()
		{
			super();
		}

		public function createField(rows:int, cols:int):void
		{
			var startX:Number = 200;
			var startY:Number = 100;
			var padding:Number = 30;
			var hitRadius:Number = 5;
			var hitObject:HitObject;
			for(var i:int = 0; i<rows; i++)
			{
				for(var j:int = 0; j<cols; j++)
				{
					hitObject = new HitObject(hitRadius);
					hitObject.x = startX+ j * padding;
					hitObject.y = startY + i * padding;
					addChild(hitObject);
				}
			}
		}
	}
}
