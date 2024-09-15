package states;

class PlayState extends Room
{
	var testShit:FlxText;

	override public function create()
	{
		testShit = new FlxText(200, 200, "Uhhhhhhhhh how did you got here?\nThat Can't be possible.", 16);
		testShit.alignment = CENTER;
		testShit.screenCenter();
		add(testShit);

		super.create();
	}
}
