package robotlegs.starling.bundles.mvcs
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class Actor
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;


		protected function dispatch(e:Event):void
		{
			if (eventDispatcher.hasEventListener(e.type))
				eventDispatcher.dispatchEvent(e);
		}

		protected function dispatchEventWith(eventString:String):void
		{
			var event:Event = new Event(eventString);
			if (eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}
	}
}
