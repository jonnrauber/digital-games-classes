package;

import flixel.FlxObject;

class Mensagem {
    public static inline var OP_DANO:Int = 0;
    public static inline var OP_CURA:Int = 1;

    public var from:Entidade;
    public var to:Entidade;
    public var data:Float;
    public var op:Int;

    public function new() {}


}