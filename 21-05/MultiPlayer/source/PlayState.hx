package;

import flixel.*;
import flixel.group.*;

class PlayState extends FlxState{
	var _players:FlxGroup;
	var _multiplayer:MultiPlayer;

	override public function create():Void{
		_players = new FlxGroup();

		_players.add(new Player(1,UP,DOWN,RIGHT,LEFT));
		_players.add(new Player(2,W,S,D,A));

		add(_multiplayer = new MultiPlayer());
		add(_players);
		super.create();
	}

	override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}

	public function getPlayerById(id:Int):Player{
		for(p in _players){
			if(cast(p,Player)._id == id){
				return cast(p,Player);
			}
		}
		return null;
	}
}
