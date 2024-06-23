import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:ludo/components/board.dart';
import 'package:ludo/components/destination.dart';
import 'package:ludo/components/dice.dart';
import 'package:ludo/config.dart';

enum PlayState { welcome, playing, gameOver, won }

class LudoGame extends FlameGame with TapCallbacks {
  late Dice dice;
  late TextComponent turnText;
  int currentPlayer = 0;
  final int totalPlayers = 4;

  LudoGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => size.x;
  double get height => size.y;
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    add(Board());
    add(Destination());
    dice = Dice(
        size: Vector2(100, 100), position: Vector2(size.x / 2, size.y - 200));
    add(dice);

    turnText = TextComponent(
      text: 'Player 1\'s turn',
      position: Vector2(size.x / 2, 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(
          style: TextStyle(fontSize: 24, color: playerColors[currentPlayer])),
    );
    add(turnText);
  }

  Future<void> rollDice() async {
    dice.roll();
    dice.animate();

    await Future.delayed(Duration(seconds: 2));
    currentPlayer = (currentPlayer + 1) % totalPlayers;
    turnText.text = 'Player ${currentPlayer + 1}\'s turn';
    turnText.textRenderer = TextPaint(
        style: TextStyle(fontSize: 24, color: playerColors[currentPlayer]));
  }

  @override
  void onTapUp(TapUpEvent event) {
    print("tap!");
    rollDice();
  }

  @override
  Color backgroundColor() => const Color(0xff0f1118);
}
