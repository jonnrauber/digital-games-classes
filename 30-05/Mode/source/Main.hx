package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite{
	public function new(){
		super();
		addChild(new FlxGame(480, 360, MultiplayerState));
		addChild(new Server());
	}
}
