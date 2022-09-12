import "package:flutter/widgets.dart";
import "package:flutter/material.dart" show Colors;
import "package:flame/game.dart";
import "sprite.dart";
import "renderer.dart";

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
      super.render(canvas, position: position, size: size);
    }
  }

  void speak(String text) {
    charman.uploadDialog(name, text);
  }
}

class CharacterManager {
  List<Character> chars = [];
  int charsOnScene = 0;

  bool dialog = true;
  String buffer = "";
  String formattedBuffer = "";
  String author = "";
  List<String> archive = [];

  CharacterManager();

  Character newCharacter(
      {required String name, spritePath = "", Vector2? size}) {
    chars.insert(
        chars.length,
        Character(
          name: name,
          spritePath: spritePath,
          size: size ?? Vector2(3, 7),
        ));
    return chars[chars.length - 1];
  }

  void onGameResize(Vector2 canvasSize) {
    _formatBuffer();
  }

  // Characters render
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
          7.1 - char.size.y,
        ),
      );
      length -= char.size.x * 2 + 0.25;
    }

    // Dialog render
    if (dialog) {
      renderDialog(canvas);
    }
  }

  // Speak component
  void _formatBuffer() {
    formattedBuffer = "";
    var maxLength = 140;
    for (var letter in buffer.split("")) {
      if (formattedBuffer.length % maxLength == 0) {
        formattedBuffer = "$formattedBuffer\n";
      }
      formattedBuffer = "$formattedBuffer$letter";
    }
  }

  // Dialogs
  void uploadDialog(String newAuthor, String newBuffer) {
    if (formattedBuffer != "" || newAuthor != "") {
      archive.insert(archive.length, "$author\n$formattedBuffer");
    }
    author = newAuthor;
    buffer = newBuffer;
    _formatBuffer();
  }

  void renderDialog(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        renderer.getSpritePosition(Vector2(0, 7.2)).y,
        renderer.screenSize.x,
        renderer.getSpriteSize(Vector2(0, 1.8)).y,
      ),
      Paint()..color = Colors.black87,
    );
    renderer.text.render(
      canvas,
      author,
      renderer.getSpritePosition(Vector2(0.1, 7.3)),
    );
    renderer.text.render(
      canvas,
      formattedBuffer,
      renderer.getSpritePosition(Vector2(0.1, 7.4)),
    );
  }
}

var charman = CharacterManager();

class Speaker {
  String name;

  Speaker({this.name = ""});

  void speak(String text) {
    charman.uploadDialog(name, text);
  }
}

var author = Speaker();
