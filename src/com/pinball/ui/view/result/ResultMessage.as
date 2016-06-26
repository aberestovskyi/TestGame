/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.ui.view.result
{
	import com.pinball.managers.AppManager;
	import com.pinball.ui.view.AbstractView;
	import com.pinball.utils.TimeoutUtils;

	import flash.filters.GlowFilter;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.text.TextField;

	public class ResultMessage extends AbstractView
	{
		private var _onOutComplete:Signal = new Signal();

		public function ResultMessage(isWin:Boolean)
		{
			super();

			var background:Image = new Image(AppManager.getInstance().assetManager.getTexture("bg_win_loose"));
			addChild(background);

			var resutlTxt:TextField = new TextField(200, 55, "", "Berlin Sans", 40, 0xFFFFFF);
			resutlTxt.nativeFilters = [new GlowFilter(0x000, 1, 3, 3, 20, 3)];
			addChild(resutlTxt);

			var valueTxt:TextField = new TextField(50, 55, "", "Berlin Sans", 40, 0xFFFFFF);
			valueTxt.nativeFilters = [new GlowFilter(0x000, 1, 3, 3, 20, 3)];
			valueTxt.y = resutlTxt.height;
			valueTxt.x = 40;
			addChild(valueTxt);

			var icon:Image = new Image(AppManager.getInstance().assetManager.getTexture("apple-big"));
			icon.x = valueTxt.x + valueTxt.width;
			icon.y = valueTxt.y - 5;
			addChild(icon);

			if (isWin)
			{
				resutlTxt.text = "YOU WIN";
				valueTxt.text = "+1";
				AppManager.getInstance().assetManager.getSound("win_snd").play();
			}
			else
			{
				resutlTxt.text = "YOU LOST";
				valueTxt.text = "-1";
				AppManager.getInstance().assetManager.getSound("lose_snd").play();
			}
		}


		override protected function complete():void
		{
			super.complete();

			x = (stage.stageWidth - width) * .5;
			y = (stage.stageHeight - height) * .5 - 30;
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
			TimeoutUtils.addTimeout(transitionOut, 2000);
		}

		private function onTransitionOutComplete():void
		{
			_onOutComplete.dispatch();
			parent.removeChild(this);
		}

		public function get onOutComplete():Signal
		{
			return _onOutComplete;
		}


		override public function destroy():void
		{
			_onOutComplete.removeAll();
			super.destroy();
		}
	}
}
