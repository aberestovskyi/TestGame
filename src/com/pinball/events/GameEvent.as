/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.events
{
	import flash.events.Event;

	public class GameEvent extends Event
	{
		public static const STARTUP:String = "STARTUP";

		private var _data:Object;
		public function GameEvent(type:String,data:Object = null)
		{
			_data = data;
			super(type);
		}

		public function get data():Object
		{
			return _data;
		}
	}
}
