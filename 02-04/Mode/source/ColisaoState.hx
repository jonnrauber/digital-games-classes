package;

import flixel.math.FlxPoint;
import flixel.FlxBasic;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class ColisaoState extends FlxState {
    var _jogador:FlxSprite;
    var _tiro:FlxSprite;

    override public function create():Void {
        _jogador = new FlxSprite(50,50);
        _jogador.angularVelocity = 45;

        _tiro = new FlxSprite(100,70);
        _tiro.mass = 10;

        add(_jogador);
        add(_tiro);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (FlxG.keys.pressed.UP) _jogador.y -= 1;
        if (FlxG.keys.pressed.DOWN) _jogador.y += 1;
        if (FlxG.keys.pressed.LEFT) _jogador.x -= 1;
        if (FlxG.keys.pressed.RIGHT) _jogador.x += 1;
        
        // FlxG.overlap(_jogador, _tiro, onOverlap);

        // var overlaps=FlxG.pixelPerfectOverlap(_jogador, _tiro);
        // if (overlaps)
        //     onOverlap(_jogador, _tiro);
        
        if (FlxG.collide(_jogador, _tiro)) {
            _tiro.velocity.x = 5;
            _tiro.acceleration.x = 10;
        }
    }

    function onOverlap(a:FlxSprite, b:FlxSprite):Void {
        b.kill();
        a.angularVelocity = 100;
    }
}