package;

import flixel.*;
import flixel.input.keyboard.*;

class PlayerM extends FlxSprite {
    public var pid:Int;
    public var simulado:Bool;
    public var ultimaSimulacao:Date;

    var _keyUp:FlxKey;
    var _keyDown:FlxKey;
    var _keyLeft:FlxKey;
    var _keyRight:FlxKey;
    var _fireKey:FlxKey;

    public function new(id:Int, keys:Array<FlxKey> = null) {
        super();        
        pid = id;

        if (keys == null) {
            simulado = true;
            ultimaSimulacao = Date.now();
            return;
        }

        _keyUp = keys[0];
        _keyDown = keys[1];
        _keyLeft = keys[2];
        _keyRight = keys[3];
        _fireKey = keys[4];
    }

    override public function update(e:Float) {
        super.update(e);

        if (FlxG.keys.anyPressed([_keyUp]) && y > 0)       y -= 1;
        if (FlxG.keys.anyPressed([_keyDown]))     y += 1;
        if (FlxG.keys.anyPressed([_keyLeft]))     x -= 1;
        if (FlxG.keys.anyPressed([_keyRight]))    x += 1;
        if (FlxG.keys.anyJustPressed([_fireKey])) {
            cast(FlxG.state, MultiplayerState).atira(x, y);
        }
    }
}