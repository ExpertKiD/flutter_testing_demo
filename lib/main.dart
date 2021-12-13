import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'app/app.dart';

final log = Logger();

Future<void> main() async {
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
