import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'game/game_screen.dart';
import 'main/main_screen.dart';

class GameManager extends FlameGame with HasCollidables, PanDetector {
  late GameScreen _gameScreen;
  late MainScreen _mainScreen;

  GameManager(){
    _mainScreen = MainScreen((){
      remove(_mainScreen);
      _gameScreen = GameScreen();
      add(_gameScreen);
    });
  }

  @override
  Future<void>? onLoad() {
    add(_mainScreen);
  }

  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    _mainScreen.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    _gameScreen.onPanUpdate(info);
  }

  void endGame(int score) {
    remove(_gameScreen);
    _mainScreen.setScore(score);
    add(_mainScreen);
  }

}