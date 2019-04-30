package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Entity1 extends FlxSprite {

    public static inline var VAGANDO_STATE = 0;
    public static inline var CORRER_STATE = 1;
    public static inline var PARADO_STATE = 2;

    var _state:Int;
    var _timeStopped:Float;

    public function new() {
        super();
        _state = VAGANDO_STATE;
        vagar();
    }

    function vagar():Void {
        this.path = new FlxPath();
        this.path.start([
            new FlxPoint(FlxG.width, 0), 
            new FlxPoint(FlxG.width, FlxG.height),
            new FlxPoint(0, FlxG.height),
            new FlxPoint(FlxG.width/2, FlxG.height/2)
            ],
            100,
            FlxPath.FORWARD
        );
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        var nextState = _state;

        if (_state == VAGANDO_STATE) {
            nextState = vagando();
        } else if (_state == CORRER_STATE) {
            nextState = correndo();
        } else if (_state == PARADO_STATE) {
            nextState = parado();
        }

        _state = nextState;
    }

    function vagando():Int {
        if (FlxMath.distanceToMouse(this) < 10)  {
            this.path = new FlxPath();
            this.path.start(
                [new FlxPoint(0,0)],
                200,
                FlxPath.FORWARD
            );
            return CORRER_STATE;
        }

        return VAGANDO_STATE;
    }

    function correndo():Int {
        if (FlxMath.distanceToPoint(this, new FlxPoint(0, 0)) <= 10) {
            _timeStopped = Date.now().getTime();
            return PARADO_STATE;
        }
        
        return CORRER_STATE;
    }

    function parado():Int {
        if (Date.now().getTime() - _timeStopped >= 5000) {
            vagar();
            return VAGANDO_STATE;
        }

        return PARADO_STATE;
    }
}
