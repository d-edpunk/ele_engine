import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'renderer.dart';

class EleSprite {
    String spritePath;
    Sprite? _sprite;
    Vector2? position;
    Vector2? size;
    bool _loaded = false;

    set sprite (String path) {
        spritePath = path;
        _loaded = false;
    }
    
    EleSprite({this.spritePath = "", this.position, this.size});
    
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
                position: renderer.getSpritePosition(position ?? Vector2(0, 0)),
                size: renderer.getSpriteSize(size ?? Vector2(3, 7)),
            );
        } else {
            canvas.drawRect(
                Rect.fromLTWH(
                    renderer.getSpritePosition(position ?? Vector2(0, 0)).x,
                    renderer.getSpritePosition(position ?? Vector2(0, 0)).y,
                    renderer.getSpriteSize(size ?? Vector2(3, 7)).x,
                    renderer.getSpriteSize(size ?? Vector2(3, 7)).y,
                ),
                Paint()
                    ..color = Colors.black,
            );
            renderer.text.render(canvas, spritePath, renderer.getSpritePosition(position ?? Vector2(0, 0)));
        }
    }
}
