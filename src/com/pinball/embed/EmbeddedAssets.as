/**
 * Created by andrey on 26.06.2016.
 */
package com.pinball.embed
{
	public class EmbeddedAssets
	{
		/*/!* PNG texture *!/
		[Embed(source="/textures/bird.png")]
		public static const bird:Class;*/

		/* ATF texture */
		[Embed(source = "/../assets/texture/spritesheet.atf", mimeType="application/octet-stream")]
		public static const spritesheet:Class;

		/* XML file */
		[Embed(source="/../assets/texture/spritesheet.xml", mimeType="application/octet-stream")]
		public static const spritesheet_xml:Class;

		/*/!* MP3 sound *!/
		[Embed(source="/audio/explosion.mp3")]
		public static const explosion:Class;*/
	}
}
