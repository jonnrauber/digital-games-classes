package;

import flixel.FlxState;

class Exercicio2State extends FlxState {

	var _sprite:Entity2;

	override public function create():Void
	{
		_sprite = new Entity2();
		_sprite.screenCenter();
		_sprite.makeGraphic(20, 20, 0xff00ff00);

		add(_sprite);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
