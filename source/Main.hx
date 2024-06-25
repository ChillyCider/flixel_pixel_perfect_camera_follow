package;

import flixel.*;
import flixel.system.scaleModes.*;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(320, 240, PlayState, 60, 60, true));

		FlxG.game.stage.quality = LOW;
		FlxG.scaleMode = new PixelPerfectScaleMode();
	}
}
