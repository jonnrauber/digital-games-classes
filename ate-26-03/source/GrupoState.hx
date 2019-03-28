package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;

class GrupoState extends FlxState {

    var _amarelosGroup:FlxGroup; //desenhar 30
    var _azuisGroup:FlxGroup; //desenhar 10
    var _verdesGroup:FlxGroup; //desenhar 15

    override public function create():Void {
        _amarelosGroup = new FlxGroup();
        _azuisGroup = new FlxGroup();
        _verdesGroup = new FlxGroup();

        var altura = 30;
        var escala = 3;
        var espacamento = 5;

        //azuis, verdes e amarelos
        for(i in 0...30) {
            var _s:FlxSprite = new FlxSprite(i*espacamento);
            _s.makeGraphic(escala, altura, 0xFFFFFF00);
            _s.y = FlxG.height - _s.height;
            _s.angularVelocity = 5;
            _s.velocity.y = -5;
            _amarelosGroup.add(_s);

            if (i >= 15) continue;

            var _s:FlxSprite = new FlxSprite(i*espacamento*2);
            _s.makeGraphic(escala*2, altura, 0xFF00FF00);
            _s.y = (FlxG.height - _s.height)/2;
            _s.angularVelocity = 10;
            _verdesGroup.add(_s);

            if (i >= 10) continue;

            var _s:FlxSprite = new FlxSprite(i*espacamento*3);
            _s.makeGraphic(escala*3, altura, 0xFF0000FF);
            _s.angularVelocity = 15;
            _s.velocity.y = 5;
            _azuisGroup.add(_s);
        }

        add(_azuisGroup);
        add(_verdesGroup);
        add(_amarelosGroup);

        super.create();
    }
}