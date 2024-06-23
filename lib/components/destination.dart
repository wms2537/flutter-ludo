import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ludo/ludo_game.dart';

class Destination extends PositionComponent with HasGameReference<LudoGame> {
  late double unitSize;
  Destination()
      : super(
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    unitSize = game.width / 15;
    size = Vector2(unitSize * 2.5, unitSize * 2.5);
    position = game.size / 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
        RRect.fromLTRBR(
            0, 0, unitSize * 2.5, unitSize * 2.5, const Radius.circular(6.0)),
        Paint()
          ..color = const Color(0xff4c4c4c)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }
}
