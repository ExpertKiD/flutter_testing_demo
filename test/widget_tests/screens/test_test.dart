import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testingdemo/services/login_service.dart';

void main() {
  Widget makeTestableWidget(Widget child, LoginService loginService) {
    return MaterialApp(
      home: child,
    );
  }

  group('Test screen test', () {
    group('Login widget tests', () {
      // Setup mock dependencies before each test
      setUp(() {
        // Mock here
      });

      tearDown(() {
        // clear mock here
      });

      testWidgets('should render', (WidgetTester tester) async {
        // Arrange

        // Act

        // Assert
      });
    });
  });
}
