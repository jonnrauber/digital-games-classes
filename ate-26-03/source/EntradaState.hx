package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;

class EntradaState extends FlxState {
    var _retTop:Jogador;
    var _retBottom:Jogador;
    var _correio:Correio;
    var _topScore:FlxText;
    var _bottomScore:FlxText;

    override public function create():Void {
        _correio = new Correio();

        _retTop = new Jogador();
        _retTop.makeGraphic(25, 25, 0xff00ff00);
        _retTop.x = (FlxG.width)/2;
        _retTop.y = 0;
        _retTop.antialiasing = true;

        _retBottom = new Jogador();
        _retBottom.makeGraphic(25, 25, 0xff0000ff);
        _retBottom.x = (FlxG.width)/2;
        _retBottom.y = FlxG.height - _retBottom.height;
        _retBottom.antialiasing = true;

        for (i in 0...50) {
            var s = new Bala();
            s.makeGraphic(5, 5, 0xffff0000);
            s.antialiasing = true;
            s.kill();
        }

        _topScore = new FlxText(0, 0, 50);
        _topScore.x = 10;
        _topScore.y = 10;
        _bottomScore = new FlxText(0, 0, 50);
        _bottomScore.x = FlxG.width - (_bottomScore.width+10);
        _bottomScore.y = FlxG.height - (_bottomScore.height+10);

        add(_correio);
        add(_retTop);
        add(_retBottom);
        add(_topScore);
        add(_bottomScore);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE) {
            var s = _bottomRet._balasBottom.getFirstAvailable();
            if (s != null) {
                s.reset(_retBottom.x + (_retBottom.width+s.width)/2, 
                    _retBottom.y - (_retBottom.width+s.width)/2);
                s.velocity.y = -50;
            }
        }
        if (FlxG.keys.justPressed.ENTER) {
            var s = _balasTop.getFirstAvailable();
            if (s != null) {
                s.reset(_retTop.x + (_retTop.width+s.width)/2, 
                    _retTop.y + (_retTop.width+s.width)/2);
                s.velocity.y = 50;
            }
        }
        if (FlxG.keys.pressed.A)
            _retTop.x -= 1;
        if (FlxG.keys.pressed.D)
            _retTop.x += 1;
        if (FlxG.keys.pressed.LEFT)
            _retBottom.x -= 1;
        if (FlxG.keys.pressed.RIGHT)
            _retBottom.x += 1;

        _topScore.text = "Life: " + _retTop.health;
        _bottomScore.text = "Life: " + _retBottom.health;
    }
}