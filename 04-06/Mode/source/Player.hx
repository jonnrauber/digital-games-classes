package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Player extends FlxSprite{
    static inline var speed = 20;

    public var pID: String;
    public var simulado:Bool;
    public var ultimaSimulacao:Date;
    
    var _upKey: FlxKey;
    var _downKey: FlxKey;
    var _leftKey: FlxKey;
    var _rightKey: FlxKey;
    var _fireKey: FlxKey;
    
    public function new(id:String, keys:Array<FlxKey> = null){
        super();
        pID = id;

        if (keys == null) {
            simulado = true;
            ultimaSimulacao = Date.now();
            return;
        }

        velocity.set(0, 0);
        maxVelocity.x = 50;
        maxVelocity.y = 50;

        _upKey = keys[0];
        _downKey = keys[1]; 
        _leftKey = keys[2]; 
        _rightKey = keys[3]; 
        _fireKey = keys[4];
    }

    override public function update(e:Float):Void{
        var mandar = false;

        super.update(e);

        if(FlxG.keys.anyPressed([_upKey])) {
            acceleration.y = -speed;
            mandar = true;
        }
        if(FlxG.keys.anyPressed([_downKey])) {
            acceleration.y = speed;
            mandar = true;
        }
            
        if(FlxG.keys.anyPressed([_leftKey])) {
            acceleration.x = -speed;
            mandar = true;
        }

        if(FlxG.keys.anyPressed([_rightKey])) {
            acceleration.x = speed;
            mandar = true;
        }

        var mp = cast(FlxG.state, MultiplayerState).mp;

        if(mandar) {
            mp.sendMove(this);
        }

        if(FlxG.keys.anyJustPressed([_fireKey]))  {
            cast(FlxG.state, MultiplayerState).atira(x, y);
            mp.send([
                Multiplayer.OP_TIRO,
                mp.getMeuIdMultiplayer(),
                x,
                y
            ]);
        }
    }
}