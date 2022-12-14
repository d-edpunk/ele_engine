import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'renderer.dart';

class EleSprite {
  String spritePath;
  Sprite? _sprite;
  Vector2 _position = Vector2(0, 0);
  Vector2 size = Vector2(3, 7);
  bool _loaded = false;

  set sprite(String path) {
    spritePath = path;
    _loaded = false;
  }

  Vector2 get position => renderer.getSpritePosition(_position);
  set position(Vector2 position) {
    _position = position;
  }

  EleSprite({this.spritePath = "", Vector2? position, Vector2? size}) {
    if (position != null) {
      _position = position;
    }
    if (size != null) {
      this.size = size;
    }
  }

  Future<void> onLoad() async {
    var image = await Flame.images.load(spritePath);
    _sprite = Sprite(image);
  }

  void render(Canvas canvas, {Vector2? position, Vector2? size}) {
    if (!_loaded) {
      onLoad();
      _loaded = true;
    }
    if (_sprite != null) {
      _sprite!.render(canvas,
          position: renderer.getSpritePosition(position ?? _position),
          size: renderer.getSpriteSize(size ?? this.size));
    } else {
      canvas.drawRect(
        Rect.fromLTWH(
          renderer.getSpritePosition(position ?? _position).x,
          renderer.getSpritePosition(position ?? _position).y,
          renderer.getSpriteSize(size ?? this.size).x,
          renderer.getSpriteSize(size ?? this.size).y,
        ),
        Paint()..color = Colors.black,
      );
      renderer.textColor = Colors.pink;
      renderer.text.render(
        canvas,
        spritePath,
        renderer.getSpritePosition(position ?? _position),
      );
    }
  }
}
