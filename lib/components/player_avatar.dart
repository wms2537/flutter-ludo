import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:ludo/ludo_game.dart';

Map<int, List<double>> spriteLocationMap = {
  0: [1, 1, 2160, 2160], // x, y, w, h
  1: [2163, 1, 2160, 2160],
  2: [1, 2163, 2160, 2160],
  3: [2163, 2163, 2160, 2160],
};

class PlayerAvatar extends SpriteComponent with HasGameReference<LudoGame> {
  PlayerAvatar(
    Vector2 positionTop,
    Vector2 positionBtm,
    int index,
  ) : super(
          position: (index == 0 || index == 1)
              ? (index % 2 == 0)
                  ? Vector2(positionTop.x * 0, positionTop.y * 1.37)
                  : Vector2(positionTop.x * 6.4, positionTop.y * 1.37)
              : (index % 2 == 0)
                  ? Vector2(positionBtm.x * 0, positionBtm.y * 1.15)
                  : Vector2(positionBtm.x * 6.4, positionBtm.y * 1.15),
          sprite: Sprite(
            Flame.images.fromCache('avatar_spritesheet.png'),
            srcPosition: Vector2(
                spriteLocationMap[index]![0], spriteLocationMap[index]![1]),
            srcSize: Vector2(
                spriteLocationMap[index]![2], spriteLocationMap[index]![3]),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    size = Vector2(150, 150);
    return super.onLoad();
  }
}
