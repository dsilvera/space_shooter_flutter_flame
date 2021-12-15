import 'package:flame/components.dart';
import 'package:spaceshooter/common/star.dart';
import 'package:spaceshooter/game_manager.dart';

class Background extends Component with HasGameRef<GameManager> {
  int nbStars;

  Background(this.nbStars);

  @override
  Future<void>? onLoad() {
    for (int i = 0; i < nbStars; i++) {
      add(Star());
    }
  }
}
