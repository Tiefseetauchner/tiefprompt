import 'package:flutter/services.dart';

enum PrompterOrientation { portrait, landscape, dynamic }

extension PrompterOrientationExtension on PrompterOrientation {
  List<DeviceOrientation> get deviceOrientation {
    switch (this) {
      case PrompterOrientation.portrait:
        return [DeviceOrientation.portraitUp];
      case PrompterOrientation.landscape:
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      case PrompterOrientation.dynamic:
        return [];
    }
  }
}
