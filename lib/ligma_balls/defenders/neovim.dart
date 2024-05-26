import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../components/auto_target_shooter.dart';
import '../components/common.dart';
import '../components/life.dart';
import '../components/projectiles.dart';
import '../components/taking_hits.dart';

class NeoVim extends SpriteComponent
    with CollisionCallbacks, Defender, Life, TakingHits {
  //
  NeoVim({required super.position, super.anchor = Anchor.center});

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('neovim.png');

    final projectile = await makeProjectilePrototype(
      ProjectileKind.vim,
      isAttacker,
      60,
    );

    add(AutoTargetShooter(radius: 64, projectile: projectile));
    add(CircleHitbox(radius: size.x / 2));

    addLifeIndicatorTo(this, maxHits: 5);
    initTakingHits(this);
  }

  double _pulseTime = 0;

  @override
  void update(double dt) {
    final pulse = 1 + sin(_pulseTime * pi * 2) * 0.1;
    scale.x = pulse;
    scale.y = pulse;

    _pulseTime += dt;
  }
}
