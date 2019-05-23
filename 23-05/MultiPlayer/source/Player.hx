package;

import flixel.*;
import flixel.input.keyboard.FlxKey;

class Player extends FlxSprite{
    public var id:Int;
    public var simulated:Bool;
    public var timeFromLastSimulation:Float;

    var _kup:FlxKey;
    var _kdown:FlxKey;
    var _kright:FlxKey;
    var _kleft:FlxKey;
    var _kfire:FlxKey;

    public function new(id:Int, ?keys:Array<FlxKey>){
        this.id = id;

        if (keys == null) {
            this.simulated = true;
            this.timeFromLastSimulation = Date.now().getTime();
        } else {
            this.simulated = false;
            this._kup = keys[0];
            this._kdown = keys[1];
            this._kright = keys[2];
            this._kleft = keys[3];
            this._kfire = keys[4];
        }
        
        super();
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);

        if(FlxG.keys.anyPressed([_kup])) y -= 1;
        if(FlxG.keys.anyPressed([_kdown])) y += 1;
        if(FlxG.keys.anyPressed([_kleft])) x -= 1;
        if(FlxG.keys.anyPressed([_kright])) x += 1;
        if(FlxG.keys.anyJustPressed([_kfire])) {
            cast(FlxG.state, PlayState)
                .atira(x, y);
        }
    }

}