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
		
		/* MP3 sound */
		[Embed(source="/../assets/audio/shoot_snd.mp3")]
		public static const shoot_snd:Class;

		[Embed(source="/../assets/audio/win_snd.mp3")]
		public static const win_snd:Class;

		[Embed(source="/../assets/audio/lose_snd.mp3")]
		public static const lose_snd:Class;
	}
}
