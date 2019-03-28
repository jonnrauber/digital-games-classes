package;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.text.FlxText;

class HUD extends FlxGroup {
    var _score:FlxText;
    var _municao:FlxText;

    public function new() {
        super();
        _score = new FlxText(5, 5, 0, "Shots: 0");
        _municao = new FlxText(FlxG.width - 20, 5, 0, "Munição: 0");
        add(_score);
    }

    override public function update(elapsed:Float):Void {
        var s:MatematicaState = cast FlxG.state;

        _score.text = "Shots: " + s._qtBullets;        

        super.update(elapsed);
    }
}