package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

class CaminhoState extends FlxState {
    var _sprite:FlxSprite;
    var _waypoints_forward:Array<FlxPoint>;
    var _waypoints_x:Array<FlxPoint>;
    var _mode:Bool;

    override public function create():Void {
        _sprite = new FlxSprite();
        _sprite.makeGraphic(20, 20, 0xffff0000);
        add(_sprite);

        _mode = true;

        _waypoints_forward = [
            new FlxPoint(_sprite.width/2,_sprite.height/2),
            new FlxPoint(FlxG.width - _sprite.width/2, _sprite.height/2),
            new FlxPoint(FlxG.width - _sprite.width/2, FlxG.height - _sprite.height/2),
            new FlxPoint(_sprite.width/2, FlxG.height - _sprite.height/2)
        ];
        _waypoints_x = [
            new FlxPoint(_sprite.width/2, _sprite.height/2),
            new FlxPoint(FlxG.width - _sprite.width/2, FlxG.height - _sprite.height/2),
            new FlxPoint(FlxG.width - _sprite.width/2, _sprite.height/2),
            new FlxPoint(_sprite.width/2, FlxG.height - _sprite.height/2)
        ];
        _sprite.path = new FlxPath().start(
            _waypoints_forward, 
            100, 
            FlxPath.LOOP_FORWARD
        );

        super.create();   
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if(FlxG.keys.justPressed.A) {
            _mode = ! _mode;
            _sprite.path = new FlxPath().start(
                _mode ? _waypoints_forward : _waypoints_x, 
                100, 
                FlxPath.LOOP_FORWARD
            );
        }
    }
}