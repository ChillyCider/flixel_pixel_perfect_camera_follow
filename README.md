# Flixel Pixel Perfect Camera Follow

If you're computer is similar to mine, you might see some twitching as the
camera follows the Player sprite. However, the issue seems to go away if we
floor the _lastTargetPosition in `FlxCamera.updateFollow()`. I don't know
if this is a correct solution, but it seems to work for me.
