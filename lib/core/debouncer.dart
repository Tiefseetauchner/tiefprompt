import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;
  Timer? _timer;
  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class PeriodicRunDebouncer extends Debouncer {
  final Duration periodicDelay;
  Timer? _periodicTimer;
  bool _actionRanSinceLastPeriodic = false;

  PeriodicRunDebouncer({required super.delay, required this.periodicDelay});

  @override
  void run(VoidCallback action) {
    _periodicTimer ??= Timer.periodic(periodicDelay, (_) {
      if (!_actionRanSinceLastPeriodic) {
        action();
      }
      _actionRanSinceLastPeriodic = false;
    });

    super.run(() {
      _actionRanSinceLastPeriodic = true;
      action();
    });
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    super.dispose();
  }
}
