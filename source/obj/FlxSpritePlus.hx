package obj;

import flixel.FlxObject;

/**
  FlxSprite with Collide Detection.

  Better than `FlxG.collide`.
**/
class FlxSpritePlus extends FlxSprite
{
  public var colider:Array<FlxObject> = [];
  // needs for overlap thing
  var _tempObj:FlxObject;
  public function new(?x:Float, ?y:Float, ?simpleGraphic:FlxGraphicAsset)
  {
    _tempObj = new FlxObject();
    _tempObj.cameras = cameras;
    super(x,y,simpleGraphic);
  }

  override function setPosition(x:Float = 0.0, y:Float = 0.0)
  {
    _tempObj.setPosition(x,y);
    for (obj in colider)
    {
      if (obj.overlaps(_tempObj, camera))
        return;
    }
    super.setPosition(x, y);
  }

  override function setGraphicSize(width:Float = 0.0, height:Float = 0.0)
  {
    _tempObj.setSize(width, height);
    super.setGraphicSize(width, height);
  }

  // Quick explan: when game sets x and y values, check the coliders overlaps to this sprite before rendering.
  // if overlaps, the values does not change.
  override function set_x(x)
  {
    _tempObj.x = x;
    for (obj in colider)
    {
      if (obj.overlaps(_tempObj, camera))
      {
        _tempObj.x = this.x;
        return this.x;
      }
    }
    return super.set_x(x);
  }

  override function set_y(y)
  {
    _tempObj.y = y;
    for (obj in colider)
    {
      if (obj.overlaps(_tempObj, camera))
      {
        _tempObj.y = this.y;
        return this.y;
      }
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

  /**
    Gets an `width` and `height` without making an `FlxSprite`.
  **/
  public static function getSizeFromImage(name:String)
  {
    final spr = AssetPath.getImage(name);
    return new FlxObject(0, 0, spr.width, spr.height);
  }
}