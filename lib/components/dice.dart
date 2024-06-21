import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dice extends PositionComponent {
  int value = 6;
  final Random random = Random();

  Dice({required Vector2 size, required Vector2 position}) {
    this.size = size;
    this.position = position;
  }

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.white;
    canvas.drawRect(size.toRect(), paint);
    final textPainter = TextPainter(
      text: TextSpan(
          text: value.toString(),
          style: TextStyle(fontSize: 50, color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.x / 2 - textPainter.width / 2,
            size.y / 2 - textPainter.height / 2));
  }

  void roll() {
    value = random.nextInt(6) + 1;
  }

  void animate() {
    add(
      ScaleEffect.to(
        Vector2.all(1.5),
        EffectController(duration: 0.2, reverseDuration: 0.2, infinite: false),
      ),
    );
  }
}
