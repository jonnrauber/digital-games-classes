package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxVector;

class Seeker extends FlxSprite {
    public function new() {
        super();

        this.x = FlxG.random.float(0, FlxG.width);
        this.y = FlxG.random.float(0, FlxG.height);

        this.maxVelocity.x = 100;
		this.maxVelocity.y = 100;
    }

    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		var dv = new FlxVector(FlxG.mouse.x - this.x, FlxG.mouse.y - this.y);
		dv.normalize();
		dv.scale(50);
		this.acceleration.x = dv.x;
		this.acceleration.y = dv.y;
	}
}