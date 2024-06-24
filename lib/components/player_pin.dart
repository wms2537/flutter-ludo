import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:ludo/ludo_game.dart';

Map<int, List<double>> spriteLocationMap = {
  0: [1, 1, 366, 590], // x, y, w, h
  1: [369, 1, 366, 590],
  2: [737, 431, 290, 472],
  3: [737, 1, 266, 428],
};

class PlayerPin extends SpriteComponent
    with TapCallbacks, HasGameReference<LudoGame> {
  Function(TapUpEvent event, PlayerPin pin) onTap;
  final int index;
  PlayerPin(Vector2 position, this.index, this.onTap)
      : super(
          position: position,
          sprite: Sprite(
            Flame.images.fromCache('spritesheet.png'),
            srcPosition: Vector2(
                spriteLocationMap[index]![0], spriteLocationMap[index]![1]),
            srcSize: Vector2(
                spriteLocationMap[index]![2], spriteLocationMap[index]![3]),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.unitSize * 0.5, game.unitSize * 0.8);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (game.currentPlayer == index && game.playerCanMove) {
      onTap(event, this);
    }
  }
}
