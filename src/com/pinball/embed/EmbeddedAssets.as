/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.embed
{
	public class EmbeddedAssets
	{
		/* PNG texture */
		[Embed(source="/../assets/image/background.png")]
		public static const background_img:Class;

		/* ATF texture */
		[Embed(source = "/../assets/texture/spritesheet.atf", mimeType="application/octet-stream")]
		public static const spritesheet:Class;

		/* XML file */
		[Embed(source="/../assets/texture/spritesheet.xml", mimeType="application/octet-stream")]
		public static const spritesheet_xml:Class;

		[Embed(source="/../assets/fonts/BRLNSB_0.ttf", embedAsCFF="false", fontFamily="Berlin Sans")]
		private static const DR_Agu:Class;


		/*/!* MP3 sound *!/
		[Embed(source="/audio/explosion.mp3")]
		public static const explosion:Class;*/
	}
}
