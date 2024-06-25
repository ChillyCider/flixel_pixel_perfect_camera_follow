package;

import flixel.*;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.*;
import flixel.util.FlxColor;
import openfl.utils.Assets;

class PlayState extends FlxState
{
	private var _defaultCam:FlxCamera;
	private var _flooredCam:FlxCamera;
	private var _label:FlxText;
	private var _level:FlxTilemap;
	private var _player:Player;

	override public function create()
	{
		super.create();

		bgColor = FlxColor.BLACK;

		_level = new FlxTilemap();
		_level.loadMapFromCSV(Assets.getText(AssetPaths.level__csv), AssetPaths.tileset__png, 16, 16, null, 1);
		add(_level);

		FlxG.worldBounds.set(_level.width, _level.height);

		_player = new Player(500, 100);
		add(_player);

		add(new FlxButton(10, 10, "Default Cam", _useDefaultCamera));
		add(new FlxButton(10, 30, "Floored Cam", _useFlooredFollowingCamera));
		_label = new FlxText();
		add(_label);

		FlxG.camera.follow(_player, LOCKON, 1);
		FlxG.camera.pixelPerfectRender = true;
		_defaultCam = FlxG.camera;

		_flooredCam = new FlooredCam();
		FlxG.cameras.add(_flooredCam);
		_flooredCam.visible = false;
		_flooredCam.follow(_player, LOCKON, 1);
		_flooredCam.pixelPerfectRender = true;

		_useDefaultCamera();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(_player, _level);
		_label.setPosition(_player.x - 60, _player.y - 20);
	}

	private function _useDefaultCamera()
	{
		_label.text = "Using Default Cam - try walking around";
		_defaultCam.visible = true;
		_flooredCam.visible = false;
	}

	private function _useFlooredFollowingCamera()
	{
		_label.text = "Using Floored Cam - try walking around";
		_defaultCam.visible = false;
		_flooredCam.visible = true;
	}
}
