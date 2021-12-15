import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:spaceshooter/game/enemy.dart';
import 'package:spaceshooter/game_manager.dart';

class Bullet extends SpriteComponent with HasGameRef<GameManager>, HasHitboxes, Collidable {
  final double _speed = 450;
  var hitboxRectangle = HitboxRectangle();

  @override
  Future<void>? onLoad() async{
    sprite = await gameRef.loadSprite('bullet.png');
    width = 32;
    height = 16;

    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
  }
}
