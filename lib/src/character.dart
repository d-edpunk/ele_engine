import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';
import 'sprite.dart';

class Character extends EleSprite {
    String name;
    bool _onScene = false;

    bool get onScene => _onScene;
    set onScene(bool newState) {
        if (newState != onScene) {
            if (newState) {
                charman.charsOnScene++;
            } else {
                charman.charsOnScene--;
            }
            _onScene = newState;
        }
    }

    Character({required this.name, super.spritePath, super.position, super.size});

    @override
    void render(Canvas canvas, {Vector2? position, Vector2? size}) {
        if (onScene) {
            super.render(
                canvas, 
                position: position, 
                size: size
            );
        }
    }
}

class CharacterManager {
    List<Character> chars = [];
    int charsOnScene = 0;

    CharacterManager();

    Character newCharacter({required String name, spritePath = "", Vector2? size}) {
        chars.insert(chars.length, Character(
            name: name,
            spritePath: spritePath,
            size: size ?? Vector2(3, 7),
        ));
        return chars[chars.length - 1];
    }

    void render(Canvas canvas) {
        var willBeRendered = <Character>[];
        for (var char in chars) {
            if (char.onScene) {
                willBeRendered.insert(willBeRendered.length, char);
            }
        }
        var length = -0.25;
        for (var char in willBeRendered) {
            length += char.size.x + 0.25;
        }
        for (var char in willBeRendered) {
            char.render(
                canvas,
                position: Vector2(
                    8 - length / 2,
                    8.9 - char.size.y,
                ),
            );
            length -= char.size.x * 2 + 0.25;
        }
    }
}
var charman = CharacterManager();
