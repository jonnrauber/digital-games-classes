package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;

class SpriteState extends FlxState {
	var _sprite:FlxSprite;

	override public function create():Void {
		_sprite = new FlxSprite(0, 0);
        _sprite.velocity.x = 20;
        _sprite.acceleration.x = 10;
        _sprite.maxVelocity.x = 50;
        _sprite.health = 10;
        // _sprite.hurt(11); //this is the same as kill()
        _sprite.scale.x = 2;
        _sprite.scale.y = 0.8;
        _sprite.angularVelocity = 10;
        _sprite.angularAcceleration = 90;
        _sprite.antialiasing = true;
		add(_sprite);
		super.create();
	}
}
