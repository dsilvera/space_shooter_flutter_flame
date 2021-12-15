import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../game_manager.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load('explosion.png'),
        srcSize: Vector2(32.0, 32.0));

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, loop: false);
    animation!.onComplete = _onComplete;
    width = 40;
    height = 40;
    anchor = Anchor.center;
  }

  void _onComplete() {
    removeFromParent();
  }
}
