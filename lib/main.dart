import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'src/game.dart';
import 'src/background.dart';
import 'src/character.dart';

class Game extends EleGame {
    Future<void> onLoad() async {
        bg.sprite = "bg.jpg";
        charman.newCharacter(
            name: "Женя",
            spritePath: "Женя.png",
            size: Vector2(5, 5),
        );
        charman.chars[0].onScene = true;
    }
}
var game = Game();

void main() {
    runApp(GameWidget(game: game));
}
