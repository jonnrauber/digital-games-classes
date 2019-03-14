package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class CreditsState extends FlxState {
    var _titulo:FlxText;
    var _subtituloProgramming:FlxText;
    var _subtituloArt:FlxText;
    var _subtituloMusic:FlxText;
    var _textoAutorProgramming:FlxText;
    var _textoAutorArt:FlxText;
    var _textoAutorMusic:FlxText;
    var _textoHaxeFlixel:FlxText;
    var _spriteHaxeFlixel:FlxSprite;
    var _btnVoltar:FlxButton;

    override public function create():Void {
        _titulo = new FlxText(0,0,0, "Credits", 20);
        _titulo.x = (FlxG.width - _titulo.width)/2.;
        _titulo.y = FlxG.height/2 - _titulo.height;
        _titulo.moves = true;
        _titulo.velocity.y = -10;

        _subtituloProgramming = new FlxText(0,0,0, "[Programming]", 13);
        _subtituloProgramming.x = (FlxG.width - _subtituloProgramming.width)/2.;
        _subtituloProgramming.y = _titulo.y + 30;
        _subtituloProgramming.moves = true;
        _subtituloProgramming.velocity.y = -10;
        _subtituloProgramming.alignment = CENTER;
        _subtituloProgramming.color = 0xffff0000;

        _textoAutorProgramming = new FlxText(0,0,0, "Jonathan T. Rauber", 10);
        _textoAutorProgramming.x = (FlxG.width - _textoAutorProgramming.width)/2.;
        _textoAutorProgramming.y = _subtituloProgramming.y + 15;
        _textoAutorProgramming.moves = true;
        _textoAutorProgramming.velocity.y = -10;
        _textoAutorProgramming.alignment = CENTER;

        _subtituloArt = new FlxText(0,0,0, "[Art]", 13);
        _subtituloArt.x = (FlxG.width - _subtituloArt.width)/2.;
        _subtituloArt.y = _textoAutorProgramming.y + 20;
        _subtituloArt.moves = true;
        _subtituloArt.velocity.y = -10;
        _subtituloArt.alignment = CENTER;
        _subtituloArt.color = 0xff00ff00;

        _textoAutorArt = new FlxText(0,0,0, "Jonathan T. Rauber", 10);
        _textoAutorArt.x = (FlxG.width - _textoAutorArt.width)/2.;
        _textoAutorArt.y = _subtituloArt.y + 15;
        _textoAutorArt.moves = true;
        _textoAutorArt.velocity.y = -10;
        _textoAutorArt.alignment = CENTER;

        _subtituloMusic = new FlxText(0,0,0, "[Music]", 13);
        _subtituloMusic.x = (FlxG.width - _subtituloMusic.width)/2.;
        _subtituloMusic.y = _textoAutorArt.y + 20;
        _subtituloMusic.moves = true;
        _subtituloMusic.velocity.y = -10;
        _subtituloMusic.alignment = CENTER;
        _subtituloMusic.color = 0xff0000ff;

        _textoAutorMusic = new FlxText(0,0,0, "Jonathan T. Rauber", 10);
        _textoAutorMusic.x = (FlxG.width - _textoAutorMusic.width)/2.;
        _textoAutorMusic.y = _subtituloMusic.y + 15;
        _textoAutorMusic.moves = true;
        _textoAutorMusic.velocity.y = -10;
        _textoAutorMusic.alignment = CENTER;


        _spriteHaxeFlixel = new FlxSprite();
        _textoHaxeFlixel = new FlxText(0,0,0, "Powered by HaxeFlixel", 10);
        _textoHaxeFlixel.x = (FlxG.width - _textoHaxeFlixel.width - _spriteHaxeFlixel.width)/2.;
        _textoHaxeFlixel.y = _textoAutorMusic.y + 20;
        _textoHaxeFlixel.moves = true;
        _textoHaxeFlixel.velocity.y = -10;
        _textoHaxeFlixel.alignment = CENTER;
        _textoHaxeFlixel.color = 0xff444444;
        
        _spriteHaxeFlixel.x = _textoHaxeFlixel.x + _textoHaxeFlixel.width + 5;
        _spriteHaxeFlixel.y = _textoHaxeFlixel.y;
        _spriteHaxeFlixel.velocity.y = -10;

        _btnVoltar = new FlxButton(0, 0, "Back", goMenu);
        _btnVoltar.x = FlxG.width - _btnVoltar.width - 10;
        _btnVoltar.y = FlxG.height - _btnVoltar.height - 10;

        add(_titulo);
        add(_subtituloProgramming);
        add(_subtituloArt);
        add(_subtituloMusic);
        add(_textoAutorProgramming);
        add(_textoAutorArt);
        add(_textoAutorMusic);
        add(_textoHaxeFlixel);
        add(_spriteHaxeFlixel);
        add(_btnVoltar);
        super.create();
    }

    function goMenu():Void {
        FlxG.switchState(new MeuMenuState());
    }
}