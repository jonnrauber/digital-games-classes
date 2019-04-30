package;

import flixel.util.FlxPath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Entity2 extends FlxSprite {

    public static inline var VAGANDO_STATE = 0;
    public static inline var CORRER_INF_ESQ_STATE = 1;
    public static inline var CORRER_INF_DIR_STATE = 2;
    public static inline var CORRER_CENTRO_STATE = 3;
    public static inline var PARADO_STATE = 4;

    var _state:Int;
    var _timeStopped:Float;

    public function new() {
        super();
        _state = VAGANDO_STATE;
        vagar();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        var nextState = _state;

        if (_state == VAGANDO_STATE) {
            nextState = vagando();
        } else if (_state == CORRER_INF_ESQ_STATE) {
            nextState = correndoInfEsq();
        } else if (_state == CORRER_INF_DIR_STATE) {
            nextState = correndoInfDir();
        } else if (_state == CORRER_CENTRO_STATE) {
            nextState = correndoCentro();
        } else if (_state == PARADO_STATE) {
            nextState = parado();
        }

        _state = nextState;
        FlxG.log.add(_state);
    }

    function vagar():Void {
        this.path = new FlxPath();
        this.path.start([
            new FlxPoint(FlxG.width - 100, 100), 
            new FlxPoint(FlxG.width - 100, FlxG.height - 100),
            new FlxPoint(100, FlxG.height - 100),
            new FlxPoint(100, 100)
            ],
            100,
            FlxPath.FORWARD
        );
    }

    function correrParaCantoInferiorEsquerdo():Void {
        this.path = new FlxPath();
        this.path.start(
            [new FlxPoint(0,FlxG.height)],
            200,
            FlxPath.FORWARD
        );
    }

    function correrParaCantoInferiorDireito():Void {
        this.path = new FlxPath();
        this.path.start(
            [new FlxPoint(FlxG.width,FlxG.height)],
            200,
            FlxPath.FORWARD
        );
    }

    function correrParaCentro():Void {
        this.path = new FlxPath();
        this.path.start(
            [new FlxPoint(FlxG.width/2,FlxG.height/2)],
            200,
            FlxPath.FORWARD
        );
    }

    function vagando():Int {
        if (FlxMath.distanceToMouse(this) < 10)  {
            correrParaCantoInferiorEsquerdo();
            return CORRER_INF_ESQ_STATE;
        }

        return VAGANDO_STATE;
    }

    function correndoInfEsq():Int {
        if (FlxMath.distanceToMouse(this) < 10)  {
            correrParaCantoInferiorDireito();
            return CORRER_INF_DIR_STATE;
        }
        if (FlxMath.distanceToPoint(this, new FlxPoint(0, FlxG.height)) < 5) {
            _timeStopped = Date.now().getTime();
            return PARADO_STATE;
        }
        
        return CORRER_INF_ESQ_STATE;
    }

    function correndoInfDir():Int {
        if (FlxMath.distanceToMouse(this) > 40)  {
            correrParaCantoInferiorEsquerdo();
            return CORRER_INF_ESQ_STATE;
        }
        
        return CORRER_INF_DIR_STATE;
    }

    function correndoCentro():Int {
        if (FlxMath.distanceToPoint(this, new FlxPoint(FlxG.width/2, FlxG.height/2)) < 5)  {
            correrParaCantoInferiorEsquerdo();
            return VAGANDO_STATE;
        }
        
        return CORRER_CENTRO_STATE;
    }

    function parado():Int {
        if (FlxMath.distanceToMouse(this) < 10)  {
            correrParaCantoInferiorDireito();
            return CORRER_INF_DIR_STATE;
        }
        if (Date.now().getTime() - _timeStopped > 10000) {
            correrParaCentro();
            return CORRER_CENTRO_STATE;
        }

        return PARADO_STATE;
    }
}
