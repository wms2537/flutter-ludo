// ignore_for_file: unused_field

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:ludo/components/board.dart';
import 'package:ludo/components/destination.dart';
import 'package:ludo/components/dice.dart';
import 'package:ludo/components/player_home.dart';
import 'package:ludo/components/player_pin.dart';
import 'package:ludo/config.dart';

enum PlayState { welcome, playing, gameOver, won }

class LudoGame extends FlameGame with TapCallbacks {
  late Dice dice;
  late Board board;
  late TextComponent turnText;
  late Destination destination;
  final List<PlayerHome> playerHomes = [];
  int _currentPlayer = 0;
  bool playerCanMove = false;
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
  double get unitSize => size.x / 15;
  Vector2 get center => size / 2;

  int get currentPlayer => _currentPlayer;

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
    await Flame.images.load('spritesheet.png');
    await Flame.images.load('avatar_spritesheet.png');

    camera.viewfinder.anchor = Anchor.topLeft;

    board = Board();
    add(board);
    final positions = [
      Vector2(center.x - unitSize * 6.25,
          center.y - unitSize * 6.25), // Top-left corner
      Vector2(center.x + unitSize * 2.25,
          center.y - unitSize * 6.25), // Top-right corner
      Vector2(center.x - unitSize * 6.25,
          center.y + unitSize * 2.25), // Bottom-left corner
      Vector2(center.x + unitSize * 2.25,
          center.y + unitSize * 2.25), // Bottom-right corner
    ];
    for (int i = 0; i < positions.length; i++) {
      playerHomes.add(PlayerHome(i, positions[i]));
      add(playerHomes.last);
    }

    destination = Destination();
    add(destination);

    dice = Dice(
        size: Vector2(100, 100), position: Vector2(size.x / 2, size.y - 200));
    add(dice);

    turnText = TextComponent(
      text: 'Player 1\'s turn',
      position: Vector2(size.x / 2, 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: playerColors[_currentPlayer],
        ),
      ),
    );
    add(turnText);
  }

  Future<void> rollDice() async {
    if (playerCanMove) return;
    dice.roll();
    dice.animate();

    await Future.delayed(const Duration(milliseconds: 500));
    playerCanMove = !playerHomes[_currentPlayer].isHomeFull || dice.value == 6;
    if (!playerCanMove) {
      nextPlayer();
    }
  }

  void nextPlayer() {
    _currentPlayer = (_currentPlayer + 1) % totalPlayers;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    turnText.text =
        'Player ${_currentPlayer + 1}\'s ${playerCanMove ? 'move turn' : 'roll dice'}';
    turnText.textRenderer = TextPaint(
        style: TextStyle(
            fontSize: unitSize * 0.8, color: playerColors[_currentPlayer]));
  }

  @override
  Color backgroundColor() => const Color(0xff0f1118);

  void addPinToBoard(PlayerPin pin) {}
}
