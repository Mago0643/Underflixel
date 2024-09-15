package backend;

import flixel.system.FlxAssets;

class Setup
{
  public static function init()
  {
    // Make Default Font to Determation Mono
		FlxAssets.FONT_DEFAULT = Fonts.DMono__ttf;
		// Make Default Logger Font to Wingdings (lmao)
		FlxAssets.FONT_DEBUGGER = Fonts.Wingdings__otf;
    ControlsManager.load();
  }
}