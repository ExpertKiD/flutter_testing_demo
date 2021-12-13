import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'app/app.dart';

final log = Logger();

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (!kReleaseMode) {
      // defaults to dump to console
      FlutterError.dumpErrorToConsole(details);

      //or, use logger to dump pretty
      log.e(details.toString(), details.exception, details.stack);
    } else {
      log.d('Sending error details to Zone');
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZonedGuarded<Future<void>>(() async {
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    if (!kReleaseMode) {
      log.e("Caught Dart Error!", error, stack);
    } else {
      log.d("Time to report to error tracking system in production");
    }
  });
}
