import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ludo/ludo_game.dart';

class Board extends RectangleComponent with HasGameReference<LudoGame> {
  Board()
      : super(
          paint: Paint()..color = const Color(0xff0f1118),
        );
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final unitSize = size.x / 15;
    final center = size / 2;
    final homeSize = unitSize * 4;
    final homePaints = [
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
      Paint()
        ..color = Colors.yellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    ];

    final positions = [
      Offset(unitSize, center.y - unitSize * 6), // Top-left corner
      Offset(size.x - homeSize - unitSize,
          center.y - unitSize * 6), // Top-right corner
      Offset(unitSize, center.y + unitSize * 2), // Bottom-left corner
      Offset(size.x - homeSize - unitSize,
          center.y + unitSize * 2), // Bottom-right corner
    ];

    for (int i = 0; i < 4; i++) {
      final rrect = RRect.fromLTRBR(
          positions[i].dx,
          positions[i].dy,
          positions[i].dx + homeSize,
          positions[i].dy + homeSize,
          const Radius.circular(16.0));
      canvas.drawRRect(
        rrect,
        homePaints[i],
      );
      canvas.drawRRect(
          rrect,
          homePaints[i]
            ..strokeWidth = 3
            ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 20));
    }

    double dxStart = unitSize * 0.75;
    double dyStart = center.y - 1.5 * unitSize;
    for (var i = 0; i < 15; i++) {
      final x = dxStart + (i % 5) * unitSize;
      final y = dyStart + (i ~/ 5) * unitSize;
      final rrect = RRect.fromLTRBR(
          x, y, x + unitSize, y + unitSize, const Radius.circular(3.0));
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = const Color(0xff606060)
          ..style = PaintingStyle.stroke,
      );
    }

    dxStart = center.x - 1.5 * unitSize;
    dyStart = center.y - 6.75 * unitSize;
    for (var i = 0; i < 15; i++) {
      final x = dxStart + (i % 3) * unitSize;
      final y = dyStart + (i ~/ 3) * unitSize;
      final rrect = RRect.fromLTRBR(
          x, y, x + unitSize, y + unitSize, const Radius.circular(3.0));
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = const Color(0xff606060)
          ..style = PaintingStyle.stroke,
      );
    }

    dxStart = center.x - 1.5 * unitSize;
    dyStart = center.y + 1.75 * unitSize;
    for (var i = 0; i < 15; i++) {
      final x = dxStart + (i % 3) * unitSize;
      final y = dyStart + (i ~/ 3) * unitSize;
      final rrect = RRect.fromLTRBR(
          x, y, x + unitSize, y + unitSize, const Radius.circular(3.0));
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = const Color(0xff606060)
          ..style = PaintingStyle.stroke,
      );
    }

    dxStart = center.x + 1.75 * unitSize;
    dyStart = center.y - 1.5 * unitSize;
    for (var i = 0; i < 15; i++) {
      final x = dxStart + (i % 5) * unitSize;
      final y = dyStart + (i ~/ 5) * unitSize;
      final rrect = RRect.fromLTRBR(
          x, y, x + unitSize, y + unitSize, const Radius.circular(3.0));
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = const Color(0xff606060)
          ..style = PaintingStyle.stroke,
      );
    }
  }
}
