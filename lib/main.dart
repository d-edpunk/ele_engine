import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'src/game.dart';
import 'src/background.dart';
import 'src/character.dart';

class Game extends EleGame {
    Character rect = charman.newCharacter(
        name: "Прямоугольник",
        spritePath: "xz chto eto"
    );
    Character zhenya = charman.newCharacter(
        name: "Женя",
        spritePath: "Женя.png",
        size: Vector2(5, 5),
    );
    Character test = charman.newCharacter(
        name: "kvadrat",
        spritePath: "kvadrat)",
        size: Vector2(3, 3),
    );

    Phraze ph = Phraze("Максимально длинный текст для проверки всякой хуйни с автопереносом. Я хуй знает, что тут еще писать. Пельмешки... Хочу пельменей... Ты нахуя это дальше читаешь, додик?", author: "kvadrat)");

    Future<void> onLoad() async {
        bg.sprite = "bg.jpg";
        rect.onScene = true;
        zhenya.onScene = true;
        test.onScene = true;
    }

    @override 
    void render(Canvas canvas) {
        super.render(canvas);
        ph.render(canvas);
    }
}
var game = Game();

void main() {
    runApp(GameWidget(game: game));
}
