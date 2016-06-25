/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.ui.view
{
	import starling.display.Sprite;
	import starling.events.Event;

	public class AbstractView extends Sprite
	{
		public function AbstractView()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			complete();
		}

		private function onRemoveFromStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			destroy();
		}

		protected function complete():void
		{

		}

		public function destroy():void
		{

		}

	}
}
