import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:ludo/components/board.dart';
import 'package:ludo/components/dice.dart';

void main() {
  runApp(GameWidget(game: LudoGame()));
}

class LudoGame extends FlameGame with TapCallbacks {
  late Dice dice;
  late TextComponent turnText;
  int currentPlayer = 0;
  final int totalPlayers = 4;
  final List<Color> playerColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow
  ];

  @override
  Future<void> onLoad() async {
    add(Board(gameSize: Vector2(200, 200)));
    dice = Dice(
        size: Vector2(100, 100),
        position: Vector2(size.x / 2 - 50, size.y / 2 - 50));
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
}
