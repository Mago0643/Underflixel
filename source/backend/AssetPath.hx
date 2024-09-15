package backend;

import haxe.Json;
import openfl.Assets;

class AssetPath
{
  /**
    @param isEmbed If `true`, the result is `assetsEmbed/`.
  **/
  public static function getPath(?isEmbed:Bool = false)
  {
    return isEmbed ? "assetsEmbed/" : "assets/";
  }

  public static function getImage(name:String)
  {
    return Assets.getBitmapData(exists(name + ".png", "images"));
  }

  // fonts should NOT be released publically
  public static function getFont(name:String, ?fontType:FontType = TTF):String
  {
    final extension = fontType == TTF ? ".ttf" : ".otf";
    return Assets.getFont(getPath() + "fonts/" + name + extension).fontName;
  }

  public static function getSound(name:String)
  {
    return Assets.getSound(exists(name, "sounds"));
  }

  public static function getMusic(name:String)
  {
    return Assets.getSound(exists(name, "music"));
  }

  public static function getJSON(name:String):Dynamic
  {
    return Json.parse(Assets.getText(exists(name + ".json", "data")));
  }

  public static function exists(name:String, library:String):String
  {
    #if DEBUG_PATH
    trace("Checking assets Folder: " + getPath() + library + "/" + name);
    trace("Checking assetsEmbed Folder: " + getPath(true) + library + "/" + name);
    #end
    if (Assets.exists(getPath() + library + "/" + name)) {
      #if DEBUG_PATH
      trace("Found in assets Folder.");
      #end
      return getPath() + library + "/" + name;
    } else if (Assets.exists(getPath(true) + library + "/" + name)) {
      #if DEBUG_PATH
      trace("Found in assetsEmbed Folder.");
      #end
      return getPath(true) + library + "/" + name;
    }
    #if DEBUG_PATH
    trace('None Found. Returning Null.');
    #end
    return null;
  }
}

enum FontType
{
  TTF;
  OTF;
}