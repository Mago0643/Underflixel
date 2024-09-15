package obj;

class BattleBox extends FlxTypedGroup<FlxSprite>
{
  public var x(default,set):Float = 0;
  public var y(default,set):Float = 0;
  public var alpha(default,set):Float = 1;
  public var angle(default,set):Float = 0;
  public var width(default,set):Int = 100;
  public var height(default,set):Int = 100;
  public var stroke(default,set):Int = 10;
  public var color(default,set):FlxColor = FlxColor.WHITE;

  public var lineUpper(default,null):FlxSprite;
  public var lineLower(default,null):FlxSprite;
  public var lineLeft(default,null):FlxSprite;
  public var lineRight(default,null):FlxSprite;

  public function new(boxWidth:Int = 100, boxHeight:Int = 100, boxStroke:Int = 10, color:FlxColor = FlxColor.WHITE)
  {
    super();

    width = boxWidth;
    height = boxHeight;
    stroke = boxStroke;
    updateBox();
    this.color = color;
  }

  /**
    Re-generate All Box Graphics.
  **/
  public function updateBox()
  {
    lineLeft.destroy();
    lineUpper.destroy();
    lineLower.destroy();
    lineRight.destroy();
    clear();

    var centerOfBox:Array<Float> = [(x+width+stroke)/2, (y+height+stroke)/2];

    lineLeft = new FlxSprite(x,y).makeGraphic(stroke, height, color);
    add(lineLeft);

    lineUpper = new FlxSprite(stroke+x,y).makeGraphic(width, stroke, color);
    add(lineUpper);

    lineLower = new FlxSprite(stroke+x,height-stroke+y).makeGraphic(width, stroke, color);
    add(lineLower);

    lineRight = new FlxSprite(width+stroke+x,y).makeGraphic(stroke, height, color);
    add(lineRight);

    lineLeft.origin.set(centerOfBox[0], centerOfBox[1]);
    lineRight.origin.set(centerOfBox[0], centerOfBox[1]);
    lineLower.origin.set(centerOfBox[0], centerOfBox[1]);
    lineUpper.origin.set(centerOfBox[0], centerOfBox[1]);
  }

  /**
    Updates position and scales of box.
  **/
  public function updateBoxTransform()
  {
    if (lineLeft == null || lineRight == null || lineLower == null || lineUpper == null) return;
    var centerOfBox:Array<Float> = [(x+width+stroke)/2, (y+height+stroke)/2];

    lineLeft.setPosition(x,y);
    lineUpper.setPosition(stroke+x,y);
    lineLower.setPosition(stroke+x,height-stroke+y);
    lineRight.setPosition(width+stroke+x,y);

    // idk this would be causing lags or not
    lineLeft.makeGraphic(stroke, height, color);
    lineUpper.makeGraphic(width, stroke, color);
    lineLower.makeGraphic(width, stroke, color);
    lineRight.makeGraphic(stroke, height, color);

    lineLeft.origin.set(centerOfBox[0], centerOfBox[1]);
    lineRight.origin.set(centerOfBox[0], centerOfBox[1]);
    lineLower.origin.set(centerOfBox[0], centerOfBox[1]);
    lineUpper.origin.set(centerOfBox[0], centerOfBox[1]);
  }

  function set_x(x)
  {
    lineLeft.x = x;
    lineUpper.x = lineLower.x = stroke + x;
    lineRight.x = width+stroke+x;
    return this.x = x;
  }

  function set_y(y)
  {
    lineLeft.y = lineUpper.y = lineRight.y = y;
    lineLower.y = height-stroke+y;
    return this.y = y;
  }

  function set_alpha(a)
  {
    lineLeft.alpha = lineUpper.alpha = lineRight.alpha = lineLower.alpha = a;
    return this.alpha = a;
  }

  function set_angle(a)
  {
    lineLeft.angle = lineUpper.angle = lineRight.angle = lineLower.angle = a;
    return this.angle = a;
  }

  function set_width(w)
  {
    width = w;
    updateBoxTransform();
    return w;
  }

  function set_height(h)
  {
    height = h;
    updateBoxTransform();
    return h;
  }

  function set_stroke(s)
  {
    stroke = s;
    updateBoxTransform();
    return s;
  }

  function set_color(c)
  {
    color = c;
    updateBoxTransform();
    return c;
  }
}