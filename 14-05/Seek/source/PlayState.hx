package;

import flixel.FlxState;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var _seekers:FlxTypedGroup<Seeker>;

	override public function create():Void
	{
		_seekers = new FlxTypedGroup<Seeker>();

		for (i in 0...10) {
			var s = new Seeker();
			_seekers.add(s);
		}

		add(_seekers);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
