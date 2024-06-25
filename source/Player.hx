package;

import flixel.*;
import flixel.util.*;

class Player extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		makeGraphic(16, 16, FlxColor.RED);

		acceleration.y = 200;
		drag.x = 200;
		maxVelocity.set(100, 200);
	}

	override public function update(elapsed:Float):Void
	{
		if (isTouching(FLOOR) && FlxG.keys.justPressed.UP)
			velocity.y = -200;

		if (FlxG.keys.pressed.LEFT == FlxG.keys.pressed.RIGHT)
			acceleration.x = 0;
		else if (FlxG.keys.pressed.LEFT)
			acceleration.x = -200;
		else if (FlxG.keys.pressed.RIGHT)
			acceleration.x = 200;

		super.update(elapsed);
	}
}
