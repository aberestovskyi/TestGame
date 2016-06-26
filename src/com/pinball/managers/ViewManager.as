/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.managers
{
	import com.pinball.ui.view.AbstractView;

	public class ViewManager
	{
		public function ViewManager()
		{
		}

		public function setView(clazz:Class, options : Object = null):void
		{
			var view:AbstractView = new clazz();
			view.options = options;
			AppManager.getInstance().core.addChild(view);
		}
	}
}
