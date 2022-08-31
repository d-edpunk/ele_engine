import 'package:flame/game.dart';
import 'sprite.dart';

class Character extends EleSprite {
    String name;

    Character(this.name, {super.spritePath, super.position, super.size});
}

var zhenya = Character(
    "Женя",
    spritePath: "Женя.png",
    size: Vector2(5, 5),
);
