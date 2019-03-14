package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class MeuMenuState extends FlxState {

    var _titulo:FlxText;
    var _btnPlay:FlxButton;
    var _btnCredits:FlxButton;
    var _btnSettings:FlxButton;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Hello World", 20);
        _titulo.x = (FlxG.width - _titulo.width)/2.;
        _titulo.y = FlxG.height/2 - _titulo.height;

        _btnPlay = new FlxButton(0, 0, "Play", goPlay);
        _btnPlay.x = _titulo.x + (_titulo.width - _btnPlay.width)/2;
        _btnPlay.y = _titulo.y + _titulo.height + 15;

        _btnCredits = new FlxButton(0, 0, "Credits", goCredits);
        _btnCredits.x = _titulo.x + (_titulo.width - _btnCredits.width)/2;
        _btnCredits.y = _btnPlay.y + _btnPlay.height + 10;

        _btnSettings = new FlxButton(0, 0, "Settings", goSettings);
        _btnSettings.x = _titulo.x + (_titulo.width - _btnSettings.width)/2;
        _btnSettings.y = _btnCredits.y + _btnCredits.height + 10;

        add(_titulo);
        add(_btnPlay);
        add(_btnCredits);
        add(_btnSettings);
        super.create();
    }

    function goPlay():Void {
        FlxG.switchState(new PlayState());
    }

    function goCredits():Void {
        FlxG.switchState(new CreditsState());
    }

    function goSettings():Void {
        FlxG.switchState(new SettingsState());
    }

}