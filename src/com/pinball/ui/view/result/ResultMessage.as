/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.view.result
{
	import com.pinball.ui.view.AbstractView;
	import com.pinball.utils.TimeoutUtils;

	import flash.filters.GlowFilter;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.text.TextField;

	public class ResultMessage extends AbstractView
	{
		public function ResultMessage(isWin:Boolean)
		{
			super();

			var resutl_txt = new TextField(200, 100, "0", "Berlin Sans", 40, 0xFFFFFF);
			resutl_txt.nativeFilters = [new GlowFilter(0x000, 1, 3, 3, 20, 3)];
			addChild(resutl_txt);

			if (isWin)
			{
				resutl_txt.text = "YOU WIN";
			}
			else
			{
				resutl_txt.text = "YOU LOST";
			}
		}


		override protected function complete():void
		{
			super.complete();

			x = (stage.stageWidth - width) * .5;
			y = (stage.stageHeight - height) * .5;
			transitionIn();
		}

		private function transitionIn():void
		{
			pivotX = width*.5;
			pivotY = height*.5;
			x+=pivotX;
			y+=pivotY;
			alpha = 0;
			scaleX = scaleY = 0.5;
			var time:Number = 0.3;
			var tween:Tween = new Tween(this, time, Transitions.EASE_OUT_BACK);
			tween.fadeTo(1);
			tween.scaleTo(1);
			tween.onComplete = onTransitionInComplete;
			Starling.juggler.add(tween);
		}

		private function transitionOut():void
		{
			var time:Number = 0.3;
			var tween:Tween = new Tween(this, time, Transitions.EASE_IN_BACK);
			tween.fadeTo(0);
			tween.scaleTo(0);
			tween.onComplete = onTransitionOutComplete;
			Starling.juggler.add(tween);
		}

		private function onTransitionInComplete():void
		{
			TimeoutUtils.addTimeout(transitionOut, 1000);
		}

		private function onTransitionOutComplete():void
		{
			parent.removeChild(this);
		}

	}
}
