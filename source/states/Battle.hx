package states;

import obj.Soul;

class Battle extends Room
{
  var soul:Soul;

  override function create()
  {
    soul = new Soul(determination);
    soul.screenCenter();
    add(soul);

    super.create();
  }
}