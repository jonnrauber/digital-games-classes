package;

import flixel.FlxG;

class Personagem extends Entidade {

    public function new() {
        super();
        health = 10;
    }

    override public function onMessage(m:Mensagem):Void {
        super.onMessage(m);
        if (m.op == Mensagem.OP_DANO) {
            this.health -= m.data;
            FlxG.log.add("Personagem recebeu " + m.data + " de dano. Vida atual = " + this.health);
            if (this.health <= 0)
                this.kill();
        }
        if (m.op == Mensagem.OP_CURA) {
            this.health += m.data;
            if (this.health > 0)
                this.reset(this.x, this.y);
            FlxG.log.add("Personagem recebeu " + m.data + " de vida. Vida atual = " + this.health);
        }
    }
}