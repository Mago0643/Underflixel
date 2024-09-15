package states;

class Splash extends Room
{
  override function create()
  {
    var title = new FlxSprite().loadGraphic(AssetPath.getImage("title"));
    title.setGraphicSize(FlxG.width, FlxG.height);
    title.updateHitbox();
    add(title);

    backend.Setup.init();
    FlxG.mouse.visible = false;
    // if you're experiencing memory leak, try to remove this one.
    for (snd in Sounds.allFiles)
      FlxG.sound.cache(snd);
    FlxG.sound.cacheAll();
    new FlxTimer().start(2.5, f -> {
      FlxG.switchState(new StoryState());
    });
    super.create();
  }
}