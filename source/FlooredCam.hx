package;

import flixel.*;
import flixel.math.*;

class FlooredCam extends FlxCamera
{
	override public function updateFollow()
	{
		// Either follow the object closely,
		// or double check our deadzone and update accordingly.
		if (deadzone == null)
		{
			target.getMidpoint(_point);
			_point.addPoint(targetOffset);
			_scrollTarget.set(_point.x - width * 0.5, _point.y - height * 0.5);
		}
		else
		{
			var edge:Float;
			var targetX:Float = Math.floor(target.x) + targetOffset.x;
			var targetY:Float = Math.floor(target.y) + targetOffset.y;

			if (style == SCREEN_BY_SCREEN)
			{
				if (targetX >= viewRight)
				{
					_scrollTarget.x += viewWidth;
				}
				else if (targetX + target.width < viewLeft)
				{
					_scrollTarget.x -= viewWidth;
				}

				if (targetY >= viewBottom)
				{
					_scrollTarget.y += viewHeight;
				}
				else if (targetY + target.height < viewTop)
				{
					_scrollTarget.y -= viewHeight;
				}

				// without this we see weird behavior when switching to SCREEN_BY_SCREEN at arbitrary scroll positions
				bindScrollPos(_scrollTarget);
			}
			else
			{
				edge = targetX - deadzone.x;
				if (_scrollTarget.x > edge)
				{
					_scrollTarget.x = edge;
				}
				edge = targetX + target.width - deadzone.x - deadzone.width;
				if (_scrollTarget.x < edge)
				{
					_scrollTarget.x = edge;
				}

				edge = targetY - deadzone.y;
				if (_scrollTarget.y > edge)
				{
					_scrollTarget.y = edge;
				}
				edge = targetY + target.height - deadzone.y - deadzone.height;
				if (_scrollTarget.y < edge)
				{
					_scrollTarget.y = edge;
				}
			}

			if ((target is FlxSprite))
			{
				if (_lastTargetPosition == null)
				{
					_lastTargetPosition = FlxPoint.get(target.x, target.y); // Creates this point.
				}

				// BEGIN NEW STUFF
				final floored = FlxPoint.get(_lastTargetPosition.x, _lastTargetPosition.y);
				if (pixelPerfectRender)
					floored.set(Math.floor(floored.x), Math.floor(floored.y));

				_scrollTarget.x += (target.x - floored.x) * followLead.x;
				_scrollTarget.y += (target.y - floored.y) * followLead.y;

				floored.put();
				// END NEW STUFF

				_lastTargetPosition.x = target.x;
				_lastTargetPosition.y = target.y;
			}
		}

		if (followLerp >= 60 / FlxG.updateFramerate)
		{
			scroll.copyFrom(_scrollTarget); // no easing
		}
		else
		{
			scroll.x += (_scrollTarget.x - scroll.x) * followLerp * (60 / FlxG.updateFramerate);
			scroll.y += (_scrollTarget.y - scroll.y) * followLerp * (60 / FlxG.updateFramerate);
		}
	}
}
