/**
 * Created by andrey on 25.06.2016.
 */
package com.pinball.utils
{
	import flash.geom.Point;

	public class Vector2dUtils
	{
		public function Vector2dUtils()
		{
		}

		// find new vector bouncing from v2
		public static function getBounceVector(ball:Point, dx:Number, dy:Number, lx:Number, ly:Number):Point
		{
			// projection of v1 on v2
			var proj1:Point = projectVector(ball, dx, dy);
			// projection of v1 on v2 normal
			var proj2:Point = projectVector(ball, lx, ly);

			// reverse projection on v2 normal
			var lang:Number = Math.sqrt(proj2.x*proj2.x+proj2.y*proj2.y);
			proj2.x = lx*lang;
			proj2.y = ly*lang;

			// add the projections
			var proj:Point = new Point();
			proj.x = proj1.x+proj2.x;
			proj.y = proj1.y+proj2.y;
			return proj;
		}

		public static function projectVector(v1:Point, dx:Number, dy:Number):Point
		{
			var dotProduct:Number = v1.x * dx + v1.y * dy;
			var proj:Point = new Point();
			proj.x = dotProduct * dx;
			proj.y = dotProduct * dy;
			return proj;
		}
	}
}
