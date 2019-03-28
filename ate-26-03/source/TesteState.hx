package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class TesteState extends FlxState {

    var _correio:Correio;
    var _personagem:Personagem;
    var _inimigo:Entidade;
    var _life:FlxText;

    override public function create():Void {
        _correio = new Correio();
        _personagem = new Personagem();
        _inimigo = new Entidade();

        _personagem.makeGraphic(10, 10, 0xff00ff00);
        _personagem.x = (FlxG.width + _personagem.width)/2;
        _personagem.y = (FlxG.height + _personagem.height)/2;

        _inimigo.makeGraphic(10, 10, 0xffff0000);
        _inimigo.x = _personagem.x - 30;
        _inimigo.y = _personagem.y - 30;

        _life = new FlxText(10, 10, 50);

        add(_personagem);
        add(_inimigo);
        add(_correio);
        add(_life);

        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        
        if (FlxG.keys.justPressed.SPACE) {
            var m:Mensagem = new Mensagem();
            m.from = _inimigo;
            m.to = _personagem;
            m.op = Mensagem.OP_DANO;
            m.data = 2;
            _correio.send(m);
        }

        if (FlxG.keys.justPressed.ENTER) {
            var m:Mensagem = new Mensagem();
            m.from = _personagem;
            m.to = _personagem;
            m.op = Mensagem.OP_CURA;
            m.data = 2;
            _correio.send(m);
        }

        if (FlxG.keys.pressed.UP) {
            _personagem.y -= 1;
        }
        if (FlxG.keys.pressed.DOWN) {
            _personagem.y += 1;
        }
        if (FlxG.keys.pressed.LEFT) {
            _personagem.x -= 1;
        }
        if (FlxG.keys.pressed.RIGHT) {
            _personagem.x += 1;
        }

        _life.text = "Vida: " + _personagem.health;
    }
}