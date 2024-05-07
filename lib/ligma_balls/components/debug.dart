import 'package:flame/components.dart';
import 'package:ligma_balls/ligma_balls/components/common.dart';

class DebugCircleHitbox extends CircleComponent with HasVisibility {
  DebugCircleHitbox({
    super.radius,
    super.position,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
    super.paintLayers,
  });

  @override
  bool get isVisible => debug;
}
