package backend;

import flixel.input.keyboard.FlxKey;

@:noCompletion @:structInit class Controls
{
  public var INTERACT_KEYS:Array<FlxKey> = [Z, ENTER];
  public var CANCEL_KEYS:Array<FlxKey> = [X, SHIFT];
  public var MENU_KEYS:Array<FlxKey> = [C, CONTROL];
  public var LEFT:Array<FlxKey> = [A, FlxKey.LEFT];
  public var DOWN:Array<FlxKey> = [S, FlxKey.DOWN];
  public var UP:Array<FlxKey> = [W, FlxKey.UP];
  public var RIGHT:Array<FlxKey> = [D, FlxKey.RIGHT];

  public var menu(get,never):Bool;
  public var menu_pressed(get,never):Bool;
  public var menu_released(get,never):Bool;

  public var interact(get,never):Bool;
  public var interact_pressed(get,never):Bool;
  public var interact_released(get,never):Bool;

  public var cancel(get,never):Bool;
  public var cancel_pressed(get,never):Bool;
  public var cancel_released(get,never):Bool;

  public var left(get,never):Bool;
  public var left_pressed(get,never):Bool;
  public var left_released(get,never):Bool;

  public var down(get,never):Bool;
  public var down_pressed(get,never):Bool;
  public var down_released(get,never):Bool;

  public var up(get,never):Bool;
  public var up_pressed(get,never):Bool;
  public var up_released(get,never):Bool;

  public var right(get,never):Bool;
  public var right_pressed(get,never):Bool;
  public var right_released(get,never):Bool;

  function get_menu() return FlxG.keys.anyJustPressed(MENU_KEYS);
  function get_menu_pressed() return FlxG.keys.anyPressed(MENU_KEYS);
  function get_menu_released() return FlxG.keys.anyJustReleased(MENU_KEYS);

  function get_interact() return FlxG.keys.anyJustPressed(INTERACT_KEYS);
  function get_interact_pressed() return FlxG.keys.anyPressed(INTERACT_KEYS);
  function get_interact_released() return FlxG.keys.anyJustReleased(INTERACT_KEYS);

  function get_cancel() return FlxG.keys.anyJustPressed(CANCEL_KEYS);
  function get_cancel_pressed() return FlxG.keys.anyPressed(CANCEL_KEYS);
  function get_cancel_released() return FlxG.keys.anyJustReleased(CANCEL_KEYS);

  function get_left() return FlxG.keys.anyJustPressed(LEFT);
  function get_left_pressed() return FlxG.keys.anyPressed(LEFT);
  function get_left_released() return FlxG.keys.anyJustReleased(LEFT);

  function get_down() return FlxG.keys.anyJustPressed(DOWN);
  function get_down_pressed() return FlxG.keys.anyPressed(DOWN);
  function get_down_released() return FlxG.keys.anyJustReleased(DOWN);

  function get_up() return FlxG.keys.anyJustPressed(UP);
  function get_up_pressed() return FlxG.keys.anyPressed(UP);
  function get_up_released() return FlxG.keys.anyJustReleased(UP);

  function get_right() return FlxG.keys.anyJustPressed(RIGHT);
  function get_right_pressed() return FlxG.keys.anyPressed(RIGHT);
  function get_right_released() return FlxG.keys.anyJustReleased(RIGHT);
}

class ControlsManager
{
  public static var data:Controls = {};
  public static function save()
  {
    for (ref in Reflect.fields(data))
      Reflect.setProperty(FlxG.save.data, ref, Reflect.getProperty(data, ref));
  }

  // idk this is working
  public static function reset()
  {
    data = {};
  }

  public static function load()
  {
    for (ref in Reflect.fields(data))
      if (Reflect.hasField(FlxG.save.data, ref))
        Reflect.setField(data, ref, Reflect.getProperty(FlxG.save.data, ref));
  }
}