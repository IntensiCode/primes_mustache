import 'package:flame/components.dart';
import 'package:ligma_balls/ligma_balls/components/soundboard.dart';
import 'package:ligma_balls/ligma_balls/components/game_over_dialog.dart';
import 'package:ligma_balls/ligma_balls/components/level_complete_dialog.dart';
import 'package:ligma_balls/ligma_balls/components/ligma_world.dart';

import '../adversaries/prime.dart';
import '../enemies/enemies.dart';

enum WinLoseState {
  stillPlaying,
  gameOver,
  levelComplete,
}

late WinLoseState state;

class WinLoseConditions extends Component {
  final Prime prime;
  final Enemies enemies;

  WinLoseConditions(this.prime, this.enemies) {
    priority = 10000;
  }

  @override
  onLoad() {
    state = WinLoseState.stillPlaying;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (state != WinLoseState.stillPlaying) {
      return;
    } else if (prime.remainingDamage == 0) {
      state = WinLoseState.gameOver;
      soundboard.play(Sound.game_over);
    } else if (enemies.allDefeated) {
      state = WinLoseState.levelComplete;
      world.score += (prime.remainingDamage.toInt() * 100);
      soundboard.play(Sound.score);
    }
    switch (state) {
      case WinLoseState.stillPlaying:
        break;
      case WinLoseState.gameOver:
        add(GameOverDialog());
      case WinLoseState.levelComplete:
        add(LevelCompleteDialog());
    }
  }
}
