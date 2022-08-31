import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'renderer.dart';

class EleSprite {
    String spritePath;
    Sprite? _sprite;
    Vector2? _position;
    Vector2? _size;
    bool _loaded = false;

    set sprite (String path) {
        spritePath = path;
        _loaded = false;
    }

    Vector2 get position => renderer.getSpritePosition(_position ?? Vector2(0, 0));
    set position (Vector2 position) {
        _position = position;
    }

    Vector2 get size => renderer.getSpriteSize(_size ?? Vector2(3, 7));
    set size (Vector2 size) {
        _size = size;
    }
    
    EleSprite({this.spritePath = "", Vector2? position, Vector2? size}) {
        if (position != null) {
            _position = position;
        }
        if (size != null) {
            _size = size;
        }
    }
    
    Future<void> onLoad() async {
        var image = await Flame.images.load(spritePath);
        _sprite = Sprite(image);
    }

    void render(Canvas canvas) {
        if (!_loaded) {
            onLoad();
            _loaded = true;
        }
        if (_sprite != null) {
            _sprite!.render(
                canvas,
                position: renderer.getSpritePosition(_position ?? Vector2(0, 0)),
                size: renderer.getSpriteSize(_size ?? Vector2(3, 7)),
            );
        } else {
            canvas.drawRect(
                Rect.fromLTWH(
                    position.x,
                    position.y,
                    size.x,
                    size.y,
                ),
                Paint()
                    ..color = Colors.black,
            );
            renderer.text.render(canvas, spritePath, renderer.getSpritePosition(_position ?? Vector2(0, 0)));
        }
    }
}
