package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxVector;

class Boid extends FlxSprite {
    public function new () {
        super();
        x = FlxG.width/2;
        y = FlxG.height/2;
        velocity.x = 2;
        velocity.y = 2;
    }

    public function seek(x:Int, y:Int):FlxVector {
        var target = new FlxVector(x, y);
        return target.subtractPoint(
            new FlxVector(this.x, this.y)
        ).normalize().scale(20);
    }

    public function flee(x:Int, y:Int):FlxVector {
        return this.seek(x, y).scale(-1);
    }

    public function arrive(x:Int, y:Int, raio:Float):FlxVector {
        var target = new FlxVector(x, y);
        var direto = target.subtractPoint(
            new FlxVector(this.x, this.y)
        );

        if (direto.length <= raio) {
            return new FlxVector(velocity.x, velocity.y)
                .normalize()
                .scale(-20);
        }
        return new FlxVector();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        var steering = new FlxVector(0, 0);
        // SEEK
        // steering.addPoint(seek(FlxG.mouse.x, FlxG.mouse.y));

        // FLEE
        // steering.addPoint(flee(FlxG.mouse.x, FlxG.mouse.y));

        // SEEK AND FLEE
        // steering.addPoint(flee(FlxG.mouse.x, FlxG.mouse.y));
        // steering.addPoint(seek(FlxG.width, FlxG.height));
        
        // SEEK AND ARRIVE
        steering.addPoint(seek(FlxG.mouse.x, FlxG.mouse.y));
        steering.addPoint(arrive(FlxG.mouse.x, FlxG.mouse.y, 50));
        acceleration.x = steering.x;
        acceleration.y = steering.y;
    }
}