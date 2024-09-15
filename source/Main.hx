package;

import openfl.text.TextFormat;
import openfl.display.FPS;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fpsBar:FPS;
	public static var fpsFormat(default,set):TextFormat = new TextFormat();
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, states.Battle, 60, 60, true));

		fpsBar = new FPS(10, 10, 0xFFFFFFFF);
		fpsFormat = new TextFormat(AssetPath.getFont("DMono"), 16, 0xFFFFFFFF);
		addChild(fpsBar);
	}

	static function set_fpsFormat(t)
	{
		fpsBar?.setTextFormat(t);
		return fpsFormat = t;
	}
}
