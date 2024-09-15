package backend;

class FlxStringTools
{
  /**
    Changes `t` to blank string in `s`.
  **/
  public static function remove(s:String, t:String)
  {
    return s.replace(t, '');
  }

  /**
    Parses an Hexadecimal color.

    @param s The Color String.
    @param checkString If true, checks the color in `FlxColor.colorLookup`.
  **/
  public static function parseColor(s:String, ?checkString:Bool = true):FlxColor
  {
    if (checkString)
    {
      var col:FlxColor = FlxColor.WHITE;
      for (name => value in FlxColor.colorLookup.keyValueIterator())
      {
        if (name.toLowerCase().trim() == s.toLowerCase().trim())
        {
          col = value;
          break;
        }
      }
      return col;
    }
    var colorStr = s;
    if (s.startsWith("#"))
      colorStr = s.replace('#', '0x');
    else if (!s.startsWith("0x"))
      colorStr = "0x" + s;

    return Std.parseInt(colorStr);
  }
}