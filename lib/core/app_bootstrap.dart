import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talker/talker.dart';
import 'package:flutter/widgets.dart';

void registerCrashHandlers(Talker talker) {
  FlutterError.onError = (FlutterErrorDetails details) {
    talker.handle(details.exception, details.stack, 'Flutter framework error');
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught platform error');
    return true;
  };
}
