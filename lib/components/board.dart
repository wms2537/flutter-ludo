import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Board extends Component {
  final Vector2 gameSize;

  Board({required this.gameSize});

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final homeSize = 400.0;
    final homePaints = [
      Paint()..color = Colors.red,
      Paint()..color = Colors.green,
      Paint()..color = Colors.blue,
      Paint()..color = Colors.yellow,
    ];

    final positions = [
      Offset(0, 0), // Top-left corner
      Offset(gameSize.x - homeSize, 0), // Top-right corner
      Offset(0, gameSize.y - homeSize), // Bottom-left corner
      Offset(
          gameSize.x - homeSize, gameSize.y - homeSize), // Bottom-right corner
    ];

    for (int i = 0; i < 4; i++) {
      canvas.drawRect(
        Rect.fromLTWH(positions[i].dx, positions[i].dy, homeSize, homeSize),
        homePaints[i],
      );
    }
  }
}
