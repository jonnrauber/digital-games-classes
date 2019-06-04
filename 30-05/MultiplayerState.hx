package;

import flixel.*;
import flixel.group.*;

class MultiplayerState extends FlxState {
    public var players:FlxGroup;
    public var tiros:FlxGroup;
    var _multiplayer:Multiplayer;

    override public function create():Void {
        players = new FlxGroup();

        players.add(new PlayerM(0, [W, S, A, D, SPACE]));
        // players.add(new PlayerM(2, UP, DOWN, LEFT, RIGHT));

        tiros = new FlxGroup();
        for (i in 0...100) {
            tiros.add(new Tiro());
        }

        add(players);
        add(_multiplayer = new Multiplayer());
        add(tiros);

        super.create();
    }
    
    public function atira(x:Float, y:Float):Void {
        var t:Tiro = cast tiros.getFirstAvailable();

        if (t != null) {
            t.reset(x, y);
            t.velocity.x = 200;
        }
    }

    public function getPlayerById(id:Int):PlayerM {
        for (p in players) {
            if (cast(p, PlayerM).pid == id) {
                return cast(p, PlayerM);
            }
        }
        return null;
    }

    override public function update(elapsed:Float):Void {
        // FlxG.log.add(getPlayerById(1)._id);
        super.update(elapsed);
    }
}