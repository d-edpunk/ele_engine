import "package:flutter/widgets.dart" show TextStyle;
import "package:flutter/material.dart" show Color, Colors;
import "package:flame/game.dart";

class Renderer {
    Vector2 screenSize = Vector2(0, 0);
    Color color = Colors.white;
    late TextPaint text;

    bool get isPortraight => screenSize.x > screenSize.y ? false : true;

    Renderer() {
         text = TextPaint(
            style: TextStyle(
                fontSize: 0.0,
                fontFamily: "Awesome Font",
                color: color,
            ),
        );
    }

    set textColor (Color newColor) {
        color = newColor;
        onGameResize(screenSize);
    }

    void onGameResize(Vector2 canvasSize) {
        screenSize.x = canvasSize.x;
        screenSize.y = canvasSize.y;

        text = TextPaint(
            style: TextStyle(
                fontSize: screenSize.y / 9 / 4,
                fontFamily: "Awesome Font",
            ),
        );
    }

    Vector2 getSpritePosition(Vector2 position) {
        if (!isPortraight) {
            return Vector2((screenSize.x - screenSize.y / 9 * 16) / 2 + screenSize.y / 9 * position.x, screenSize.y / 9 * position.y);
        } else {
            return Vector2(screenSize.x / 16 * position.x, (screenSize.y - screenSize.x / 16 * 9) / 2 + screenSize.x / 16 * position.y);
        }
    }

    Vector2 getSpriteSize(Vector2 size) {
        if (!isPortraight) {
            return Vector2(screenSize.y / 9 * size.x, screenSize.y / 9 * size.y);
        } else {
            return Vector2(screenSize.x / 16 * size.x, screenSize.x / 16 * size.y);
        }
    }
}

var renderer = Renderer();
