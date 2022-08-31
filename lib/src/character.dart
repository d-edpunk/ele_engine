import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';
import 'sprite.dart';

class Character extends EleSprite {
    String name;
    bool onScene = false;

    Character({required this.name, super.spritePath, super.position, super.size});

    @override
    void render(Canvas canvas) {
        if (onScene) {
            super.render(canvas);
        }
    }
}

class CharacterManager {
    List<Character> chars = [];

    CharacterManager();

    void newCharacter({required String name, spritePath = "", Vector2? size}) {
        chars.insert(chars.length, Character(
            name: name,
            spritePath: spritePath,
            size: size ?? Vector2(3, 7),
        ));
    }

    void render(Canvas canvas) {
        for (var char in chars) {
            char.render(canvas);
        }
    }
}
var charman = CharacterManager();
