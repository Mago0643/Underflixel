package states;

import obj.DialogueText;
import backend.Controls;
import flixel.util.FlxSpriteUtil;

class StoryState extends Room
{
  // So, storySide is the Original Story Images.
  // mask is white squre thing to use masking.
  // fSprite is result of the mask.

  var storySide:FlxSprite;
  var mask:FlxSprite;
  var fSprite:FlxSprite;
  var curIntro:Int = 0;
  var activeMask:Bool = false;
  var wow:DialogueText;

  override function create()
  {
    storySide = new FlxSprite().loadGraphic(AssetPath.getImage('story/introlast'));
    mask = new FlxSprite().makeGraphic(200, 100);
    fSprite = new FlxSprite(0,200).loadGraphic(AssetPath.getImage('story/intro_1'));
    fSprite.setGraphicSize(FlxG.width, FlxG.height);
    fSprite.updateHitbox();
    fSprite.screenCenter();
    add(fSprite);

    FlxG.sound.play(AssetPath.getMusic("mus_story.ogg"));

    wow = new DialogueText();
    wow.dialogueData = AssetPath.getJSON("dialogue/intro_story");
    wow.startData();
    add(wow);

    super.create();
  }

  var blah:Bool = false;
  override function update(elapsed:Float)
  {
    if (activeMask) fSprite = FlxSpriteUtil.alphaMaskFlxSprite(storySide, mask, fSprite);
    fSprite.screenCenter(X);

    // skip
    if (!blah && ControlsManager.data.interact)
    {
      blah = true;
      FlxTween.tween(FlxG.camera, {alpha: 0}, .5);
    }

    super.update(elapsed);
  }
}