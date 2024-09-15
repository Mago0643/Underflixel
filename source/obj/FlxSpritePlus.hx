package obj;

import flixel.FlxObject;

/**
  FlxSprite with Collide Detection.

  Better than `FlxG.collide`.
**/
class FlxSpritePlus extends FlxSprite
{
  public var coliders:Array<FlxObject> = [];
  // needs for overlap thing
  var _tempObj:FlxObject;
  public function new(?x:Float, ?y:Float, ?simpleGraphic:FlxGraphicAsset)
  {
    _tempObj = new FlxObject();
    super(x,y,simpleGraphic);
  }

  override function setPosition(x:Float = 0.0, y:Float = 0.0)
  {
    updateTempObjectPosition(x, y, width, height, angle);
    for (obj in coliders)
    {
      if (obj.overlaps(_tempObj, camera))
        return;
    }
    super.setPosition(x, y);
  }

  override function setGraphicSize(width:Float = 0.0, height:Float = 0.0)
  {
    updateTempObjectPosition(x, y, width, height, angle);
    super.setGraphicSize(width, height);
  }

  function updateTempObjectPosition(x:Float, y:Float, w:Float, h:Float, a:Float)
  {
    _tempObj.setPosition(x, y);
    _tempObj.setSize(w, h);
    _tempObj.angle = a;
    return _tempObj;
  }

  // Quick explan: when game sets x and y values, check the coliders overlaps to this sprite before rendering.
  // if overlaps, the values does not change.
  override function set_x(x)
  {
    _tempObj.x = x;
    for (obj in coliders)
    {
      if (obj.overlaps(_tempObj, camera))
        return this.x;
    }
    return super.set_x(x);
  }

  override function set_y(y)
  {
    _tempObj.y = y;
    for (obj in coliders)
    {
      if (obj.overlaps(_tempObj, camera))
        return this.y;
    }
    return super.set_y(y);
  }

  override function set_angle(a)
  {
    _tempObj.angle = a;
    return super.set_angle(a);
  }

  override function set_width(w)
  {
    _tempObj.width = w;
    return super.set_width(w);
  }

  override function set_height(h)
  {
    _tempObj.height = h;
    return super.set_height(h);
  }
}