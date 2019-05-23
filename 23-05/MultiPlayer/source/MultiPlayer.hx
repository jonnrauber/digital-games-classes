package;

import flixel.*;

class MultiPlayer extends FlxObject{
    // msg array index 0 has ever OP_CODE
    // msg array index 1 has ever _idJogador
    public static inline var OP_NOVO_JOGADOR:String = "N";
    public static inline var OP_MOVE:String = "M"; // [2:x, 3:y, 4:velocity.x, 5:velocity.y]
    public static inline var OP_TIRO:String = "T"; // [2:x, 3:y]

    var _cont:Float = 0;
    var _idJogador:Int;

    public function new(){
        super();
        _idJogador = -1;
    }

    public function send(msg:Array<Any>):Void {
        onMessage(msg);
    }

    /**
    Retorna true se precisa processar a mensagem
    **/
    function deveProcessarMsg(idRemetente:Int):Bool {
        if (idRemetente == _idJogador) return false;
        
        var p:Player = cast(FlxG.state, PlayState)
                            .getPlayerById(idRemetente);
        
        if (p == null) {
            cast(FlxG.state, PlayState)
                ._players.add(new Player(idRemetente));
        }

        return true;
    }

    public function onMessage(msg:Array<Any>):Void {
        if (msg == null || msg.length == 0) {
            FlxG.log.error("Mensagem mal formada!");
            return;
        }

        var op:String = cast(msg[0], String);
        var idRemetente:Int = cast(msg[1], Int);

        if (!deveProcessarMsg(idRemetente))
            return;

        switch (op) {
            case OP_MOVE:
                if (msg.length != 6) {
                    FlxG.log.error("Mensagem de movimento mal formada!");
                    return;
                }
                    
                var x:Int = cast(msg[2], Int);
                var y:Int = cast(msg[3], Int);
                var velx:Float = cast(msg[4], Float);
                var vely:Float = cast(msg[5], Float);
                trataMove(idRemetente, x, y, velx, vely);
            case OP_TIRO:
                if (msg.length != 4) {
                    FlxG.log.error("Mensagem de tiro mal formada!");
                    return;
                }
                var x:Int = cast(msg[2], Int);
                var y:Int = cast(msg[3], Int);
                trataTiro(idRemetente, x, y);
            default:
                FlxG.log.error("OP erro: " + op);
        }
    }

    public function trataTiro(idRemetente:Int, x:Int, y:Int):Void {
        var state = cast(FlxG.state, PlayState);
        var p:Player = state.getPlayerById(idRemetente);

        if (p != null) {
            p.x = x;
            p.y = y;
            state.atira(x, y);
        }
    }

    public function trataMove(idRemetente:Int, x:Int, y:Int, velx:Float, vely:Float):Void {
        var p:Player = cast(FlxG.state, PlayState)
                            .getPlayerById(idRemetente);

        if (p != null) {
            p.x = x;
            p.y = y;
            p.velocity.x = velx;
            p.velocity.y = vely;
        }
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
        _cont += elapsed;

        if (_cont >= 5) { 
            _cont = 0;
            send([OP_MOVE, 2, 100, 150, 10, 10]);
            send([OP_TIRO, 2, 100, 150]);
        }
    }
}