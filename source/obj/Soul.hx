package obj;

class Soul extends FlxSpritePlus
{
  public static var SOUL_COLORS = [FlxColor.CYAN, FlxColor.ORANGE, FlxColor.BLUE, FlxColor.PURPLE, FlxColor.GREEN, FlxColor.YELLOW, FlxColor.RED];
  public var type(default,set):SoulType;
  public var box(default,set):BattleBox;
  public var canMove:Bool = true;
  public function new(soulType:SoulType, box:BattleBox)
  {
    super();

    loadGraphic(AssetPath.getImage('soulWhite'), true, 16, 16);
    animation.add('normal', [0], 10);
    animation.add('hurt', [1,0], 10);
    animation.play('normal', true);
    type = soulType;
    this.box = box;
  }

  // TODO: Make Soul Mechanics.
  function set_type(t)
  {
    color = SOUL_COLORS[t];
    
    centerOrigin();
    return type = t;
  }

  /**
    Soul's Speed. It's pps. (Pixels per Second)
  **/
  public var speed:Float = 150;
  override function update(elapsed:Float)
  {
    if (canMove)
    {
      if (ControlsManager.data.left_pressed && x > 0)
        x -= elapsed * speed;
      if (ControlsManager.data.right_pressed && x < FlxG.width-width)
        x += elapsed * speed;
      if (ControlsManager.data.up_pressed && y > 0)
        y -= elapsed * speed;
      if (ControlsManager.data.down_pressed && y < FlxG.height-height)
        y += elapsed * speed;
    }

    super.update(elapsed);
  }

  function set_box(b)
  {
    box = b;
    colider = [b.lineLeft, b.lineLower, b.lineRight, b.lineUpper];
    return b;
  }
}

enum abstract SoulType(Int) from Int to Int
{
  /**
    Cyan soul.
  **/
  var patience = 0;
  /**
    Orange soul.
  **/
  var bravery = 1;
  /**
    Blue soul.
  **/
  var integrity = 2;
  /**
    Purple soul.
  **/
  var perseverance = 3;
  /**
    Green soul.
  **/
  var kindness = 4;
  /**
    Yellow soul. (Please play Undertale Yellow.)
  **/
  var justice = 5;
  /**
    Red soul.
  **/
  var determination = 6;
}