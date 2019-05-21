package;

import flixel.*;
import flixel.input.keyboard.FlxKey;

class Player extends FlxSprite{
    public var _id:Int;
    var _kup:FlxKey;
    var _kdown:FlxKey;
    var _kright:FlxKey;
    var _kleft:FlxKey;
    
    public function new(id:Int, kup:FlxKey, kdown:FlxKey, kright:FlxKey, kleft:FlxKey){
        _id = id;
        _kup = kup;
        _kdown = kdown;
        _kright = kright;
        _kleft = kleft;
        super();
    }
    override public function update(elapsed:Float):Void{
        super.update(elapsed);

        if(FlxG.keys.anyPressed([_kup])) y -= 1;
        if(FlxG.keys.anyPressed([_kdown])) y += 1;
        if(FlxG.keys.anyPressed([_kleft])) x -= 1;
        if(FlxG.keys.anyPressed([_kright])) x += 1;
    }

}