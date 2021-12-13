import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sentry/sentry.dart';

import 'app/app.dart';

bool isDebugMode() {
  bool isInDebugMode = false;
  assert(isInDebugMode == false);
  return isInDebugMode;
}

final _log = Logger();

final _sentry = SentryClient(SentryOptions(
    dsn:
        'https://a27d08e9edf5482c89aa076073be65b7@o1087080.ingest.sentry.io/6104827'));

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) async {
      if (isDebugMode()) {
        // defaults to dump to console
        FlutterError.dumpErrorToConsole(details);

        //or, use logger to dump pretty
        _log.e(details.toString(), details.exception, details.stack);
      } else {
        _log.d('Sending error details to Zone');
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    if (isDebugMode()) {
      _log.e("Caught Dart Error!", error, stack);
    } else {
      _log.d("Time to report to error tracking system in production");
      _sentry.captureException(error, stackTrace: stack);
    }
  });
}
