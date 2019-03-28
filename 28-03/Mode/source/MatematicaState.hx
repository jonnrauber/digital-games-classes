package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxVector;

class MatematicaState extends FlxState {
    public var _qtBullets:Int = 0;
    var _cannon:FlxSprite;
    var _vel:FlxVector = new FlxVector();
    var _hud:HUD;
    public var _bullets:FlxTypedGroup<Bala>;
    
    override public function create():Void {
        _cannon = new FlxSprite(FlxG.width / 2, FlxG.height - 20);
        _hud = new HUD();
        _bullets = new FlxTypedGroup<Bala>();

        _vel.x = 0;
        _vel.y = 0;

        for (i in 0...10) {
            var b = new Bala();
            b.makeGraphic(10, 10, 0xffff0000);
            b.angularVelocity = 1000;
            b.kill();
            _bullets.add(b);
        }

        add(_cannon);
        add(_hud);
        add(_bullets);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        if (FlxG.mouse.justPressed) {
            _vel.x = FlxG.mouse.x - _cannon.x;
            _vel.y = FlxG.mouse.y - _cannon.y;
            _vel.normalize();
            _vel.scale(100);

            var b = _bullets.getFirstAvailable();
            if (b != null) {
                b.reset(_cannon.x, _cannon.y);            
                b.velocity.x = _vel.x;
                b.velocity.y = _vel.y;

                _qtBullets++;
            }
        }

        super.update(elapsed);
    }

    public function calculaVetor(x1:Float, y1:Float, x2:Float, y2:Float):FlxVector {
        var v = new FlxVector(x1-x2, y1-y2);
        return v;
    }
}