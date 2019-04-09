package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;

class ArteState extends FlxState {

    var _rpgPlayer:FlxSprite;
    var _goku:FlxSprite;

    override public function create():Void {
        _rpgPlayer = new FlxSprite();
        _rpgPlayer.loadGraphic(AssetPaths.rpg_sprite_walk__png, true, 24, 32);
        _rpgPlayer.setFacingFlip(FlxObject.LEFT, true, false);
        _rpgPlayer.setFacingFlip(FlxObject.RIGHT, false, false);
        _rpgPlayer.facing = FlxObject.RIGHT;
        _rpgPlayer.animation.add("up", [0,1,2,3,4,5,6,7], 15);
        _rpgPlayer.animation.add("down", [8,9,10,11,12,13,14,15], 15);
        _rpgPlayer.animation.add("left", [16,17,18,19,20,21,22,23], 15);
        _rpgPlayer.animation.add("right", [24,25,26,27,28,29,30,31], 15);

        _goku = new FlxSprite();
        _goku.loadGraphic(AssetPaths.goku__png, true, 24, 32);
        _goku.setFacingFlip(FlxObject.LEFT, true, false);
        _goku.setFacingFlip(FlxObject.RIGHT, false, false);
        _goku.facing = FlxObject.RIGHT;
        _goku.animation.add("up", [0,1,2,3,4,5,6,7], 15);
        _goku.animation.add("down", [8,9,10,11,12,13,14,15], 15);
        _goku.animation.add("left", [16,17,18,19,20,21,22,23], 15);
        _goku.animation.add("right", [24,25,26,27,28,29,30,31], 15);

        add(_rpgPlayer);
        add(_goku);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justReleased.ANY) {
            _rpgPlayer.animation.stop();
        }

        if (FlxG.keys.pressed.LEFT) {
            _rpgPlayer.x -= 1;
            _rpgPlayer.animation.play("left");
        }
        if (FlxG.keys.pressed.RIGHT) {
            _rpgPlayer.x += 1;
            _rpgPlayer.animation.play("right");
        }
        if (FlxG.keys.pressed.UP) {
            _rpgPlayer.y -= 1;
            _rpgPlayer.animation.play("down");
        }
        if (FlxG.keys.pressed.DOWN) {
            _rpgPlayer.y += 1;
            _rpgPlayer.animation.play("up");
        }
    }



}