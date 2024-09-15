package obj;

import backend.Controls;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.input.keyboard.FlxKey;

// theres a class for FlxTypeText, but it looks like doesnt fit with this one.
class DialogueText extends FlxText
{
  /**
    Adjusts how much should shake?
  **/
  public var shakeX:Float = 10;
  /**
    Adjusts how much should shake?
  **/
  public var shakeY:Float = 10;
  /**
    The sounds will not play if typer types this.

    Default is `*\t \n`. (star, tab, space, switch line)
  **/
  public var ignoreText:String = '*\t \n';
  /**
    Typing sound.

    Default is `txtdef`. `(assets/sounds/text/txtdef.ogg)`
  **/
  public var typeSound:String = 'txtdef';
  /**
    If Player Presses these keys, The text finishes typing instantly.
  **/
  public var skipKeys:Array<FlxKey> = Controls.CANCEL_KEYS.copy();
  /**
    If `false`, Player cannot skip this dialogue with `skipKeys`.
  **/
  public var canSkip:Bool = true;
  /**
    Called when text finished typing or `skipKeys` is Pressed.
  **/
  public var onFinished:FlxTypedSignal<String->Void>;
  /**
    * . . .
  **/
  public var dialogueData:DialogueData;
  /**
    Current Dialogue Number. (0 indexed)
  **/
  public var curDialogue:Int = 0;
  public function new(?font:String = '', ?x:Float, ?y:Float, ?fieldWidth:Float, ?size:Int)
  {
    super(x,y,fieldWidth,"",size);
    if (font != '')
      this.font = font;
    onFinished = new FlxTypedSignal<String->Void>();
  }

  var _delays:Array<Float> = [];
  var _colors:Array<FlxColor> = [];
  var _targetText:String;
  /**
    `~delay seconds~` to adjust text speed.

    `~color hex~` to change colors. (0xAARRGGBB)

    ex. `"* This is an ~delay 0.05~~color 0xFFFF0000~Test ~delay 0.025~Text."`
  **/
  public function typeText(text:String, ?delay:Float = 0.025)
  {
    if (text.trim() == "" || text.trim() == this.text || delay < 0.001) return;
    _delays = [];
    _targetText = "";
    _colors = [];

    // ["* This is an ", "delay 0.05", "Test ", "delay 0.025", "Text", "."]
    var a = text.split("~");

    var curDelay:Float = delay;
    var curColor:FlxColor = FlxColor.WHITE;
    for (i in 0...a.length)
    {
      if (a[i] == "") continue;
      // using startsWith() function cuz if i use contains(), it will be applied to texts that has like "* This machine has delay."
      if (a[i].startsWith("delay"))
        curDelay = Std.parseFloat(a[i].remove('delay').trim());
      else if (a[i].startsWith("color"))
        curColor = a[i].remove('color').trim().parseColor();
      else {
        _targetText += a[i];
        _delays.push(curDelay);
        _colors.push(curColor);
      }
    }

    start();
  }

  /**
    Starts Dialogue with `dialogueData`.
  **/
  public function startData()
  {
    typeText(dialogueData.dialogue[0].text);
  }

  var started:Bool = false;
  var timer:Float = 0;
  function start()
  {
    if (_targetText == text || _targetText.trim() == "") return;
    timer = 0;
    text = "";
    curIndex = 0;
    started = true;
  }

  var curIndex:Int = 0;
  override function update(elapsed:Float)
  {
    if (started && timer > 0)
    {
      timer = _delays[curIndex];
      text += _targetText.charAt(curIndex);
      if (!_targetText.charAt(curIndex).contains(ignoreText))
        FlxG.sound.play('assets/sounds/text/${typeSound}.wav');
      var bbb = textField.getTextFormat(curIndex, curIndex);
      bbb.color = _colors[curIndex];
      textField.setTextFormat(bbb);
      // end
      if (_targetText.charAt(curIndex+1) == '') {
        started = false;
        timer = 0;
        curIndex = 0;
        onFinished.dispatch(text);
        curDialogue++;
      } else curIndex++;
    }

    if (started && FlxG.keys.anyJustPressed(skipKeys) && canSkip)
      skipText();

    // continue next dialogue
    if (!started && Controls.interact && text == _targetText)
    {
      curDialogue++;
      // end of dialogue script
      if (curDialogue >= dialogueData.dialogue.length) return;
      final data = dialogueData.dialogue[curDialogue];
      typeText(data.text);
      font = data.font;
      canSkip = !data.cannotSkip;
    }

    super.update(elapsed);
  }

  /**
    Finishes the Text instantly.
  **/
  public function skipText()
  {
    started = false;
    timer = 0;
    text = _targetText;
    for (a in 0...text.length)
    {
      var b = textField.getTextFormat(a, a);
      b.color = _colors[a];
      textField.setTextFormat(b);
    }
    curIndex = 0;
    onFinished.dispatch(text);
  }

  public function clearText()
  {
    skipText();
    text = "";
  }
}

typedef DialogueTextData =
{
  var text:String;
  var char:String;
  @:optional var font:String;
  var offset:Float; // how much seconds should spent until this dialogue actives.
  var cannotSkip:Bool; // can't skip the dialogue by keys.
  var forceEnd:Int; // the dialogue force ends if character index going past of this.
}

typedef DialogueData =
{
  var dialogue:Array<DialogueTextData>;
  var id:String;
}