import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flame/game.dart";
import "package:flame/input.dart";
import "renderer.dart";
import "background.dart";
import "character.dart";
import "slide.dart";

class EleGame extends FlameGame with KeyboardEvents {
  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    renderer.onGameResize(canvasSize);
    charman.onGameResize(canvasSize);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    bg.render(canvas);
    charman.render(canvas);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isKeyDown && isSpace) {
      slideman + 1;
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
