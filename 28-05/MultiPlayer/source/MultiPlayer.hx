package;

import flixel.*;

class MultiPlayer extends FlxObject{
    // msg array index 0 has ever OP_CODE
    // msg array index 1 has ever _idJogador
    public static inline var OP_NOVO_JOGADOR:String = "N";
    public static inline var OP_MOVE:String = "M"; // [2:x, 3:y, 4:velocity.x, 5:velocity.y]
    public static inline var OP_TIRO:String = "T"; // [2:x, 3:y]
    public static inline var OP_MORREU:String = "D"; // [2:x, 3:y]

    public static inline var _overflowInterval:Float = 1;
    var _overflowTimer:Float = 0;
    var _overflowLastOp:String = "";
    var _cont:Float = 0;

    var _idJogador:Int;

    public function new(){
        super();
        _idJogador = -1;
    }

    public function getMeuIdMultiplayer():Int {
        return _idJogador;
    }

    public function send(msg:Array<Any>):Void {
        onMessage(msg);
    }

    public function sendMove(p:Player):Void {
        sendNoOverflow([
            OP_MOVE, 
            _idJogador, 
            p.x, 
            p.y,
            p.velocity.x,
            p.velocity.y,
            p.acceleration.x,
            p.acceleration.y
        ]); 
    }

    public function sendNoOverflow(msg:Array<Any>):Void {
        var op = msg[0];
        if (op == _overflowLastOp) return;
        _overflowLastOp = op;
        send(msg);
        FlxG.log.add("send no overflow");
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
            case OP_MORREU:
                if (msg.length != 4) {
                    FlxG.log.error("Mensagem de morto mal formada!");
                    return;
                }
                var x:Int = cast(msg[2], Int);
                var y:Int = cast(msg[3], Int);
                trataMorreu(idRemetente, x, y);
            default:
                FlxG.log.error("OP erro: " + op);
        }
    }

    public function trataMorreu(idRemetente:Int, x:Int, y:Int):Void {
        var state = cast(FlxG.state, PlayState);
        var p:Player = state.getPlayerById(idRemetente);

        if (p != null) {
            p.x = x;
            p.y = y;
            p.kill();
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
        var state = cast(FlxG.state, PlayState);
        var p:Player = state.getPlayerById(idRemetente);

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
        _overflowTimer += elapsed;

        if (_overflowTimer > _overflowInterval) {
            _overflowTimer = 0;
            _overflowLastOp = "";
        }

        if (_cont >= 5) { 
            _cont = 0;
            sendNoOverflow([OP_MOVE, 2, 100, 150, 10, 10]);
            sendNoOverflow([OP_TIRO, 3, 200, 100]);
        }
    }
}