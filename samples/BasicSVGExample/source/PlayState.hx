package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxSVGSprite;
import flixel.math.FlxRandom;
import openfl.Assets;

using StringTools;

/**
 * @author UncertainProd
 * 
 * A basic example showcasing a bunch of FlxSVGSprites and adjusting their positions and rotations
 * by making them *bounce*
 * 
 * The SVG files are taken from (twemoji)[https://github.com/twitter/twemoji] under Creative Commons
 */
class PlayState extends FlxState
{
	var svgSprites:Array<FlxSVGSprite>;
	var svgs:Array<String>;

	override public function create()
	{
		super.create();
		svgSprites = [];
		svgs = Assets.list().filter((s) -> s.endsWith('.svg'));

		var i = 0;
		for (svgfile in svgs)
		{
			var svgspr = new FlxSVGSprite((i * 110) % FlxG.width, 110 * Math.floor(i * 110 / FlxG.width), 100, 100, svgfile);
			svgSprites.push(svgspr);
			add(svgspr);
			svgspr.acceleration.y = 500;
			i++;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		for (s in svgSprites)
		{
			if (s.y + s.displayHeight >= FlxG.height)
			{
				s.velocity.y = -400 - (Math.random() * 50 - 25);
				s.angularVelocity = Math.random() * 60 - 30;
				s.velocity.x = Math.random() * 20 - 10;
			}
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.random.shuffle(svgs);
			for (i in 0...svgSprites.length)
			{
				svgSprites[i].loadSVGGraphic(svgs[i]);
			}
		}
	}
}
