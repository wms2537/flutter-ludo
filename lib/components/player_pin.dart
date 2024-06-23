import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ludo/ludo_game.dart';

Map<int, List<double>> spriteLoactionMap = {
  0: [1, 1, 366, 590], // x, y, w, h
  1: [369, 1, 366, 590],
  2: [737, 431, 290, 472],
  3: [737, 1, 266, 428],
};

class PlayerPin extends SpriteComponent with HasGameReference<LudoGame> {
  PlayerPin(Vector2 position, int index)
      : super(
          position: position,
          sprite: Sprite(
            Flame.images.fromCache('spritesheet.png'),
            srcPosition: Vector2(
                spriteLoactionMap[index]![0], spriteLoactionMap[index]![1]),
            srcSize: Vector2(
                spriteLoactionMap[index]![2], spriteLoactionMap[index]![3]),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.unitSize * 0.5, game.unitSize * 0.8);
    return super.onLoad();
  }
}