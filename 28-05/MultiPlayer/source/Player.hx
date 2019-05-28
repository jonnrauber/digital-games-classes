package;

import flixel.*;
import flixel.input.keyboard.FlxKey;

class Player extends FlxSprite{
    public static inline var speed = 15;

    public var id:Int;
    public var simulated:Bool;
    public var timeFromLastSimulation:Float;

    var _kup:FlxKey;
    var _kdown:FlxKey;
    var _kright:FlxKey;
    var _kleft:FlxKey;
    var _kfire:FlxKey;

    public function new(id:Int, ?keys:Array<FlxKey>){
        super();

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
        velocity.set(0, 0);
        maxVelocity.set(60, 60);
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);

        var mandar:Bool = false;

        if(FlxG.keys.anyPressed([_kup])) {
            acceleration.y = -speed;
            mandar = true;
        }
        if(FlxG.keys.anyPressed([_kdown])) {
            acceleration.y = speed;
            mandar = true;
        }
        if(FlxG.keys.anyPressed([_kleft])) {
            acceleration.x = -speed;
            mandar = true;
        }
        if(FlxG.keys.anyPressed([_kright])) {
            acceleration.x = speed;
            mandar = true;
        }

        var mp = cast(FlxG.state, PlayState).multiplayer;

        if (mandar) {
            mp.sendMove(this);
        }

        if(FlxG.keys.anyJustPressed([_kfire])) {
            cast(FlxG.state, PlayState).atira(x, y);
            mp.sendNoOverflow([
                MultiPlayer.OP_TIRO,
                mp.getMeuIdMultiplayer(),
                this.x,
                this.y
            ]);
        }
    }

}