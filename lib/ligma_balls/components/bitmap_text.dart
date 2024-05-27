import 'dart:ui';

import 'package:flame/components.dart';

import '../util/bitmap_font.dart';
import 'common.dart';

class BitmapText extends PositionComponent {
  final String text;
  final BitmapFont font;
  final double fontScale;
  final Color tint;

  BitmapText({
    required this.text,
    required Vector2 position,
    BitmapFont? font,
    double scale = 1,
    this.tint = const Color(0xFFffffff),
  })  : font = font ?? textFont,
        fontScale = scale {
    this.position = position;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    font.scale = fontScale;
    font.tint(tint);
    font.drawString(canvas, 0, 0, text);
  }
}
