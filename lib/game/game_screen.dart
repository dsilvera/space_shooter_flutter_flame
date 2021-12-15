import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/common/background.dart';
import 'package:spaceshooter/game_manager.dart';

import 'bullet.dart';
import 'enemy.dart';
import 'explosion.dart';
import 'player.dart';

class GameScreen extends Component with HasGameRef<GameManager> {
  static const int playerLevelByScore = 20;
  late Player _player;
  late TextComponent _playerScore;
  late Timer enemySpawner;
  late Timer bulletSpawner;
  int score = 0;

  @override
  Future<void>? onLoad() {
    enemySpawner = Timer(2, onTick: _spawnEnemy, repeat: true);
    bulletSpawner = Timer(2, onTick: _spawnBullet, repeat: true);

    add(Background(50));

    _playerScore = TextComponent(
        text: "Score : 0",
        position: Vector2(gameRef.size.toRect().width / 2, 10),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 48.0,
            color: Colors.white,
          ),
        ));
    add(_playerScore);


    _player = Player(_onPlayerTouch);
    add(_player);
  }

  void _spawnBullet(){
    var bullet = Bullet();
    bullet.position = _player.position.clone();
    add(bullet);
  }

  void _spawnEnemy() {
    for (int i = 0; i <= min(score ~/ playerLevelByScore, 2); i++) {
      add(Enemy(_onEnemyTouch));
    }
  }

  void _onPlayerTouch(){
    gameRef.endGame(score);
  }

  void _onEnemyTouch(Vector2 position){
    var explosion = Explosion();
    explosion.position = position;
    add(explosion);
    score++;
    _playerScore.text = "Score : $score";

    if (score % playerLevelByScore == 0) {
      bulletSpawner.stop();
      bulletSpawner = Timer(
          min(1 / (score ~/ playerLevelByScore), 1).toDouble(),
          onTick: _spawnBullet,
          repeat: true);
    }
  }

  void onPanUpdate(DragUpdateInfo info) {
    if (isMounted) {
      _player.move(info.delta.game);
    }
  }

  @override
  void onMount() {
    super.onMount();
    enemySpawner.start();
    bulletSpawner.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawner.update(dt);
    bulletSpawner.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    enemySpawner.stop();
    bulletSpawner.stop();
  }

}