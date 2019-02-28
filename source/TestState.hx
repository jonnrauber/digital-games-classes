import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxState;

class TestState extends FlxState {

    var _sprite:FlxSprite;

    var _char:FlxSprite;
    var _chao:FlxSprite;
    var _tree:FlxSprite;
    var _tree_up:FlxSprite;

    var _text:FlxText;

    override public function create():Void {

        _sprite = new FlxSprite();
        _sprite.makeGraphic(50,50,0xffff0000);
        _sprite.velocity.x = 5;
        _sprite.angle = 40;
        _sprite.angularVelocity = 5;

        _char = new FlxSprite();
        _char.makeGraphic(20, 100, 0xff0000ff);
        _char.x = 150;
        _char.y = 100;
        _char.angle = 10;

        _chao = new FlxSprite();
        _chao.makeGraphic(320, 40, 0xff00ff00);
        _chao.y = 200;

        _tree = new FlxSprite();
        _tree_up = new FlxSprite();
        _tree.makeGraphic(30, 150, 0xff3e2723);
        _tree_up.makeGraphic(100, 100, 0xff1b5e20);
        _tree.y = 50;
        _tree.x = 240;
        _tree_up.y = 30;
        _tree_up.x = 205;

        _text = new FlxText();
        _text.text = "Hello World";
        _text.angularVelocity = 5;
        _text.velocity.x = 5;
        _text.angle = 5;

        add(_sprite);
        add(_char);
        add(_chao);
        add(_tree);
        add(_tree_up);
        add(_text);

        super.create();
    }
}