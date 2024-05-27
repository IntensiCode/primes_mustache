import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/services.dart';

import '../util/bitmap_font.dart';
import '../util/nine_patch_image.dart';
import 'common.dart';

class BitmapButton extends PositionComponent
    with TapCallbacks, KeyboardHandler {
  //
  final NinePatchImage? background;
  final String text;
  final BitmapFont font;
  final double fontScale;
  final Color tint;
  final int cornerSize;
  final Function onTap;
  final List<String> shortcuts;

  BitmapButton({
    Image? bgNinePatch,
    required this.text,
    this.cornerSize = 16,
    required Vector2 position,
    required Vector2 size,
    BitmapFont? font,
    this.shortcuts = const [],
    this.fontScale = 1,
    this.tint = const Color(0xFFffffff),
    required this.onTap,
  })  : font = font ?? textFont,
        background = bgNinePatch != null
            ? NinePatchImage(bgNinePatch, cornerSize: cornerSize)
            : null {
    this.position = position;
    this.size = size;
  }

  @override
  render(Canvas canvas) {
    background?.draw(canvas, 0, 0, size.x, size.y);

    font.scale = fontScale;
    font.tint(tint);

    final xOff = (size.x - font.lineWidth(text)) / 2;
    final yOff = (size.y - font.lineHeight()) / 2;
    font.drawString(canvas, xOff, yOff, text);
  }

  @override
  void onTapUp(TapUpEvent event) => onTap();

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyRepeatEvent) return true;
    if (event is! KeyDownEvent) return true;
    if (event case KeyDownEvent it) {
      if (shortcuts.contains(it.logicalKey.keyLabel)) {
        onTap();
        return true;
      }
    }
    return false;
  }
}
