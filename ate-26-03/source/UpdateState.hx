package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class UpdateState extends FlxState {
    var _sprite:FlxSprite;
    var _bullet:FlxSprite;
    var _hud:HUD;

    override public function create():Void {
        _sprite = new FlxSprite();
        _bullet = new FlxSprite();
        _bullet.makeGraphic(5, 5, 0xffff0000);
        _bullet.kill();
        _hud = new HUD();

        add(_sprite);
        add(_bullet);
        add(_hud);
        super.create();
    }


    override public function update(elapsed:Float):Void {
        // if (FlxG.keys.justPressed.UP) {
        // justPressed não observa se mantém pressionada a tecla    
        // }

        if (FlxG.keys.pressed.UP) {
            _sprite.y -= 1; //go up
        }
        if (FlxG.keys.pressed.LEFT) {
            _sprite.x -= 1; //go up
        }
        if (FlxG.keys.pressed.RIGHT) {
            _sprite.x += 1; //go up
        }
        if (FlxG.keys.pressed.DOWN) {
            _sprite.y += 1; //go up
        }
        if (! _sprite.isOnScreen()) {
            if (_sprite.x + _sprite.width < 0) {
                _sprite.x = FlxG.width - 1;
            }
            if (_sprite.y + _sprite.height < 0) {
                _sprite.y = FlxG.height - 1;
            }
            if (_sprite.x > FlxG.width) {
                _sprite.x = 1 - _sprite.height;
            }
            if (_sprite.y > FlxG.height) {
                _sprite.y = 1 - _sprite.width;
            }
        }

        if (FlxG.keys.justPressed.SPACE) {
            _bullet.reset(_sprite.x+(_sprite.width-_bullet.width)/2, 
                            _sprite.y+(_sprite.height-_bullet.height)/2);
        }

        if (_bullet.alive) {
            _bullet.x += 10;
            if (! _bullet.isOnScreen()) {
                _bullet.kill();
            }
        }
        


        super.update(elapsed);
    }


}