import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:ludo/components/player_avatar.dart';
import 'package:ludo/components/player_pin.dart';
import 'package:ludo/config.dart';
import 'package:ludo/ludo_game.dart';

class PlayerHome extends PositionComponent with HasGameReference<LudoGame> {
  final int playerIndex;
  late TextComponent playerName;

  PlayerHome(this.playerIndex, Vector2 position) : super(position: position);
  List<String> playerNames = [
    "Carlos",
    "Mohdi",
    "Yixuan",
    "Jupeng",
  ];
  Map avatarBgVector = {
    0: [1, 1], // x, y
    1: [2163, 1],
    2: [1, 2163],
    3: [2163, 2163],
  };
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.unitSize * 2.5, game.unitSize * 2.5);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //player home
    final rrect = RRect.fromLTRBR(0, 0, game.unitSize * 4, game.unitSize * 4,
        const Radius.circular(16.0));
    final paint = Paint()
      ..color = playerColors[playerIndex]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      rrect,
      paint,
    );
    canvas.drawRRect(
        rrect,
        paint
          ..strokeWidth = 3
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15));
    //player avatar bg
    final avatarBgRRect = (playerIndex == 0 || playerIndex == 1)
        ? (playerIndex % 2 == 0)
            ? RRect.fromLTRBR(
                //top left
                0,
                game.unitSize * -4.5,
                game.unitSize * 2.7,
                game.unitSize * -1.8,
                const Radius.circular(24.0),
              )
            : RRect.fromLTRBR(
                //top right
                70,
                game.unitSize * -4.5,
                game.unitSize * 4,
                game.unitSize * -1.8,
                const Radius.circular(24.0),
              )
        : (playerIndex % 2 == 0)
            ? RRect.fromLTRBR(
                //bottom left
                0,
                game.unitSize * 5,
                game.unitSize * 2.7,
                game.unitSize * 7.8,
                const Radius.circular(24.0),
              )
            : RRect.fromLTRBR(
                //bottom right
                70,
                game.unitSize * 5,
                game.unitSize * 4,
                game.unitSize * 7.8,
                const Radius.circular(24.0),
              );

    final avatarBgPaint = Paint()
      ..color = playerColors[playerIndex]
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawRRect(
      avatarBgRRect,
      avatarBgPaint,
    );
    canvas.drawRRect(
      avatarBgRRect,
      avatarBgPaint
        ..strokeWidth = 3
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15),
    );

    //player name
    playerName = TextComponent(
      text: playerNames[playerIndex],
      position: (playerIndex == 0 || playerIndex == 1)
          ? (playerIndex % 2 == 0)
              ? Vector2(size.x / 2, size.y / -2)
              : Vector2(size.x / 0.95, size.y / -2)
          : (playerIndex % 2 == 0)
              ? Vector2(size.x / 2, size.y / 0.295) //btm left
              : Vector2(size.x / 0.95, size.y / 0.295), //btm right
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
    add(playerName);

    add(
      PlayerPin(
        Vector2(game.unitSize * 1, game.unitSize * 1),
        playerIndex,
        (event, pin) {
          if (game.dice.value == 6) {
            game.board.addPin(removePin(pin));
            game.playerCanMove = false;
          }
        },
      ),
    );
    add(
      PlayerPin(
        Vector2(game.unitSize * 2.5, game.unitSize * 1),
        playerIndex,
        (event, pin) {
          if (game.dice.value == 6) {
            game.board.addPin(removePin(pin));
            game.playerCanMove = false;
          }
        },
      ),
    );
    add(
      PlayerPin(
        Vector2(game.unitSize * 1, game.unitSize * 2.2),
        playerIndex,
        (event, pin) {
          if (game.dice.value == 6) {
            game.board.addPin(removePin(pin));
            game.playerCanMove = false;
          }
        },
      ),
    );
    add(
      PlayerPin(
        Vector2(game.unitSize * 2.5, game.unitSize * 2.2),
        playerIndex,
        (event, pin) {
          if (game.dice.value == 6) {
            game.board.addPin(removePin(pin));
            game.playerCanMove = false;
          }
        },
      ),
    );
  }

  PlayerPin removePin(PlayerPin pin) {
    remove(pin);
    return pin;
  }
}
