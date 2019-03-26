package;

import flixel.group.FlxGroup;

class Jogador extends Entidade {
    var _score:Int;
    var _balas:FlxTypedGroup<Bala>;

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }

    public function new() {
        super();
        health = 100;
        _balas = new FlxTypedGroup<Bala>();
    }

    override public function onMessage(m:Mensagem):Void {
        super.onMessage(m);

        if (m.op == Mensagem.OP_DANO) {
            this.health -= 20;
        }
    }

}