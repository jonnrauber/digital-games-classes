package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

class Exercicio2State extends FlxState {
    var _sprite:FlxSprite;
    var _waypoints:Array<FlxPoint>;

    override public function create():Void {
        _sprite = new FlxSprite();
        _sprite.makeGraphic(20, 20, 0xffff0000);
        _waypoints = [];

        _sprite.path = new FlxPath().start(
            _waypoints, 
            100, 
            FlxPath.LOOP_FORWARD
        );

        add(_sprite);
        super.create();   
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.mouse.justPressed) {
            if (_waypoints.length < 10) {

                _waypoints.push(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));

                _sprite.path = new FlxPath().start(
                    _waypoints, 
                    100, 
                    FlxPath.LOOP_FORWARD
                );
                
                var clique:FlxText = new FlxText(FlxG.mouse.x, FlxG.mouse.y, "" + _waypoints.length);
                add(clique);
            }
        }
    }
}