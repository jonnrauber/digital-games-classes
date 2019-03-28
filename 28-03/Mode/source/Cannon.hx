package;

import flixel.FlxSprite;

class Cannon extends FlxSprite {
    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (! this.isOnScreen()) {
            this.kill();
        }
    }

    public function new() {
        super();
    }
}