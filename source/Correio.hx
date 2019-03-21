package;

import flixel.FlxG;
import flixel.FlxObject;

class Correio extends FlxObject {
    var _fila:Array<Mensagem> = [];

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        for (m in _fila) {
            m.to.onMessage(m);
        }

        _fila.splice(0, _fila.length);
    }

    public function send(m:Mensagem):Void {
        _fila.push(m);
    }

}