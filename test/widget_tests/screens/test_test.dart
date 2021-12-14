import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testingdemo/screens/test.dart';
import 'package:testingdemo/services/login_service.dart';

import '../../mocks/services/login_service_mock.dart';

void main() {
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  group('Test screen test', () {
    group('Login widget tests', () {
      late LoginService loginService;

      // Setup mock dependencies before each test
      setUp(() {
        // Mock here
        loginService = MockLoginService();

        when(() => loginService.loginWithUsernameAndPassword(
                'username', 'password'))
            .thenAnswer((invocation) => Future.value(true));
        when(() => loginService.loginWithUsernameAndPassword(any(), any()))
            .thenAnswer((invocation) => Future.value(false));
      });

      tearDown(() {
        // clear mock here
        reset(loginService);
      });

      testWidgets('should render', (WidgetTester tester) async {
        // Arrange
        TestScreen testScreen = TestScreen(loginService: loginService);

        // Act
        await tester.pumpWidget(
          makeTestableWidget(testScreen),
        );

        expect(find.byType(TestScreen), findsOneWidget);
        // Assert
      });
    });
  });
}
