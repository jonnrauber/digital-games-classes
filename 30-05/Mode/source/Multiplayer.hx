package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

import networking.Network;
import networking.sessions.Session;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

class Multiplayer extends FlxSprite{
    public static inline var IP_SERVIDOR:String = "127.0.0.1";

    // No indice zero, sempre tem o OP.
    public static inline var OP_NOVO_JOGADOR:String = "n";
    public static inline var OP_MOVE:String = "m"; // 1:id, 2:x 3:y 4:vx 5:vy
    public static inline var OP_TIRO:String = "t"; // 1:id, 2:xp 3:yp
    public static inline var OP_MORREU:String = "o"; // 1:id, 2:xp 3:yp

    var _cont: Float = 0;
    var _overflowTimer:Float = 0;
    var _overflowInterval:Float = 5; // tempo minimo, em segundos, entre mensagens passiveis de overflow
    var _overflowLastOp:String = "";
    var _idJogador:Int;

    public function new(){
        super();
        _idJogador = -1;
        criaCliente();
    }

    function criaCliente():Void {
        var client = Network.registerSession(NetworkMode.CLIENT, {
            ip: IP_SERVIDOR,
            port: 8888,
            flash_policy_file_url: 'http://' + IP_SERVIDOR + ':9999/crossdomain.xml'
        });

        // When a client recieves a message ...
        client.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(event: NetworkEvent) {
            // event.data.x
            FlxG.log.add(event.data);
        });

        client.start();
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

    public function send(msg:Array<Any>):Void {
        // Acomxambrando comunicacao
        //onMessage(msg);
        var session = Network.sessions[0];
        session.send(msg);
    }

    public function getMeuIdMultiplayer():Int {
        return _idJogador;
    }

    public function sendNoOverflow(msg:Array<Any>):Void {
        var op = msg[0];

        if(op == _overflowLastOp) {
            return;
        }

        _overflowLastOp = op;
        send(msg);
        FlxG.log.add("sendNoOveflow()");
    }

    // Retorna true se precisa processar a mensagem
    function confereRemetente(idRemetente:Int):Bool {
        if (idRemetente == _idJogador)
            return false;

        var p = getPlayer(idRemetente);

        if (p == null) {
            getState().players.add(new Player(idRemetente));
        }

        return true;
    }

    public function onMessage(msg:Array<Any>):Void {
        if (msg == null || msg.length == 0) {
            FlxG.log.error("Mensagem mal formada");
            return;
        }

        var op:String = msg[0];
        var idRemetente:Int = cast(msg[1], Int);
        var deveProcessarMsg = confereRemetente(idRemetente);

        if(!deveProcessarMsg)
            return;

        switch(op) {
            case OP_MOVE:
                trataMove(idRemetente,          // remetete
                          cast(msg[2], Int),    // x
                          cast(msg[3], Int),    // y
                          cast(msg[4], Float),  // vel x
                          cast(msg[5], Float)); // vely
            case OP_TIRO:
                trataTiro(idRemetente,          // remetete
                          cast(msg[2], Int),    // x
                          cast(msg[3], Int));   // y
            case OP_MORREU:
                trataMorreu(idRemetente,        // remetete
                          cast(msg[2], Int),    // x
                          cast(msg[3], Int));   // y
            default:
                FlxG.log.error("OP erro: " + op);
        }
    }

    public function trataMorreu(idRemetente:Int, x:Int, y:Int):Void {
        var p = getPlayer(idRemetente);

        if (p == null) {
            return;
        }

        p.x = x;
        p.y = y;
        p.kill();
    }

    public function getState():MultiplayerState {
        var state:MultiplayerState = 
           cast(FlxG.state, MultiplayerState);

        return state;
    }

    public function getPlayer(id:Int):Player {
        var state:MultiplayerState = getState();
        var p = state.getPlayerByID(id); 
        return p;
    }
  
    public function trataTiro(idRemetente:Int, x:Int, y:Int):Void {
        var state:MultiplayerState = getState();
        var p = getPlayer(idRemetente);

        if(p == null)
            return;

        p.x = x;
        p.y = y;
        state.atira(x, y);
    }

    public function trataMove(idRemetente:Int, x:Int, y:Int, vx:Float, vy:Float):Void {
        var p = getPlayer(idRemetente);

        if(p != null) {
            p.x = x;
            p.y = y;
            p.velocity.x = vx;
            p.velocity.y = vy;
        }
    }

    override public function update(e:Float):Void{
        super.update(e);

        _cont += e;
        _overflowTimer += e;

        if (_overflowTimer >= _overflowInterval) {
            _overflowTimer = 0;
            _overflowLastOp = "";
        }

        if(_cont >= 5){
            /*
            send([OP_MOVE, 1, 100, 150, 20, 20]);
            send([OP_MOVE, 2, 100, 150, 0, 20]);
            send([OP_MOVE, 3, 100, 150, 0, 80]);
            send([OP_MOVE, 4, 100, 150, 80, 80]);
            send([OP_TIRO, 1, 100, 150]);
            send([OP_MORREU, 2, 100, 150]);
            send([OP_MORREU, 3, 100, 150]);
            send([OP_MORREU, 4, 100, 150]);
            */
        }
    }
}