package obj;

class BattleButton extends FlxSprite
{
  // Set this for custom button colors
  public static var BUTTON_COLOR_NORMAL:FlxColor = 0xFFFF7F27;
  public static var BUTTON_COLOR_SELECTED:FlxColor = 0xFFFFFF00;

  public var id(default,set):BButtonType = FIGHT;
  public var selected(default,set):Bool = false;
  public function new(id:BButtonType)
  {
    super();
    this.id = id;
  }

  function set_selected(b:Bool)
  {
    animation.play(b ? "select" : "normal");
    color = b ? BUTTON_COLOR_SELECTED : BUTTON_COLOR_NORMAL;
    return selected = b;
  }

  function set_id(t)
  {
    loadGraphic(AssetPath.getImage('button_sheet'), true, 110, 42);
    animation.add('normal', [0 + (t * 2)]);
    animation.add('select', [1 + (t * 2)]);
    animation.play('normal', true);
    color = BUTTON_COLOR_NORMAL;
    setPosition(20 + (t * (width + 55)), FlxG.height - height - 15);
    return id = t;
  }
}

enum abstract BButtonType(Int) from Int to Int
{
  var FIGHT = 0;
  var ACT = 1;
  var ITEM = 2;
  var MERCY = 3;
}