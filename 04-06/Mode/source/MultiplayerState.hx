package;

import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;

class MultiplayerState extends FlxState{
    public var players: FlxGroup;
	public var tiros: FlxGroup;
	public var mp: Multiplayer;

	override public function create():Void{		
		players = new FlxGroup();
		players.add(new Player("1", [FlxKey.UP, FlxKey.DOWN, FlxKey.LEFT, FlxKey.RIGHT, FlxKey.SPACE]));

		tiros = new FlxGroup();
		for(i in 0...100) {
			tiros.add(new Tiro());
		}

		mp = new Multiplayer();

		add(players);
		add(tiros);
		add(mp);

		super.create();
	}

	public function getPlayerByID(id: String): Player{
		for (p in players)
			if(cast(p, Player).pID == id)
				return cast(p, Player);
		
		return null;
	}

	public function atira(x:Float, y:Float):Void {
        var t:Tiro = cast tiros.getFirstAvailable();

		if (t != null) {
			t.reset(x, y);
			t.velocity.x = 40;
		}
    }

	override public function update(e:Float):Void{
		super.update(e);
	}
}
