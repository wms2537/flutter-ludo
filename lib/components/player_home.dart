import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:ludo/components/player_pin.dart';
import 'package:ludo/config.dart';
import 'package:ludo/ludo_game.dart';

class PlayerHome extends PositionComponent with HasGameReference<LudoGame> {
  final int playerIndex;
  PlayerHome(this.playerIndex, Vector2 position) : super(position: position);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.unitSize * 2.5, game.unitSize * 2.5);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
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

    add(PlayerPin(Vector2(game.unitSize * 1, game.unitSize * 1), playerIndex));
    add(PlayerPin(
        Vector2(game.unitSize * 2.5, game.unitSize * 1), playerIndex));
    add(PlayerPin(
        Vector2(game.unitSize * 1, game.unitSize * 2.2), playerIndex));
    add(PlayerPin(
        Vector2(game.unitSize * 2.5, game.unitSize * 2.2), playerIndex));
  }
}
