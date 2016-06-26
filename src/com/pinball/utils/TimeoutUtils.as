package com.pinball.utils
{
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * @author Andrey Berestovskyi
	 */
	public class TimeoutUtils
	{
		private static var _timeOuts:Dictionary = new Dictionary();
		public static function addTimeout(closure : Function, delay : Number, ...args) : uint
		{
			var uid:uint;
			args.push(closure);
			uid = setTimeout(delegate, delay, args);
			
			_timeOuts[closure] ||= [];
			var arr:Array = _timeOuts[closure];
			arr.push(uid);
			
			return uid;
		}

		private static function delegate(args: Array) : void
		{
			var closure: Function = args.pop();
			closure.apply(null, args);
			delete _timeOuts[closure];
		}
		
		public static function isHaveTimeout(closure : Function) : Boolean
		{
			return (_timeOuts[closure] != null);
		}
		
		public static function removeTimeout(closure : Function) : void
		{
			if(isHaveTimeout(closure))
			{
				var arr:Array = _timeOuts[closure];
				var leng:int = arr.length-1;
				var i:int;
				for(i = leng; i>=0; i--)
				{
					clearTimeout(arr[i]);	
				}
				
				delete _timeOuts[closure];
			}
		}
		
		public static function removeAllTimeouts() : void
		{
			for(var callback:* in _timeOuts)
			{
				removeTimeout(callback);
			}
		}
	}
}
