package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class SettingsState extends FlxState {
    var _titulo:FlxText;
    var _btnVoltar:FlxButton;
    var _btnFullScreen:FlxButton;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Settings", 20);
        _titulo.x = (FlxG.width - _titulo.width)/2.;
        _titulo.y = FlxG.height/2 - _titulo.height;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.x = FlxG.width - _btnVoltar.width - 10;
        _btnVoltar.y = FlxG.height - _btnVoltar.height - 10;

        _btnFullScreen = new FlxButton(0, 0, "Toggle Fullscreen", toggleFullscreen);
        _btnFullScreen.x = (FlxG.width - _btnFullScreen.width)/2;
        _btnFullScreen.y = _titulo.y + _titulo.height + 10;
        _btnFullScreen.width = 200;

        add(_titulo);
        add(_btnVoltar);
        add(_btnFullScreen);
        super.create();
    }

    function goMenu():Void {
        FlxG.switchState(new MeuMenuState());
    }

    function toggleFullscreen():Void {
        FlxG.fullscreen = !FlxG.fullscreen;
    }
}