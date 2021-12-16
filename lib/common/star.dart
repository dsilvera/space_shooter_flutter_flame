import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:spaceshooter/game_manager.dart';

class Star extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load("stars.png"), srcSize: Vector2(9.0, 9.0));
    animation = spriteSheet.createAnimation(
        row: Random().nextInt(3) + 1,
        stepTime: (Random().nextInt(50) / 10) + 0.2);
    var size = Random().nextInt(10).toDouble() + 10;
    var x = Random()
        .nextInt((gameRef.size.toRect().width - size).toInt())
        .toDouble();
    var y = Random()
        .nextInt((gameRef.size.toRect().height - size).toInt())
        .toDouble();

    width = size;
    height = size;
    position = Vector2(x, y);
    anchor = Anchor.center;
  }
}