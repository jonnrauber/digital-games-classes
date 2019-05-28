package;

import flixel.*;
import flixel.group.*;

class PlayState extends FlxState{
	public var _tiros:FlxGroup;
	public var _players:FlxGroup;
	public var multiplayer:MultiPlayer;

	override public function create():Void{
		_players = new FlxGroup();
		_players.add(new Player(1, [UP, DOWN, RIGHT, LEFT, SPACE]));

		_tiros = new FlxGroup();
		for (i in 0...10) {
			_tiros.add(new Tiro());
		}

		add(multiplayer = new MultiPlayer());
		add(_players);
		add(_tiros);
		super.create();
	}

	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}

	public function getPlayerById(id:Int):Player{
		for(p in _players){
			if(cast(p,Player).id == id){
				return cast(p,Player);
			}
		}
		return null;
	}

	public function atira(x:Float, y:Float):Void {
        var t:Tiro = cast _tiros.getFirstAvailable();
		if (t != null) {
			t.reset(x, y);
			t.velocity.x = 200;
		}
    }
}
