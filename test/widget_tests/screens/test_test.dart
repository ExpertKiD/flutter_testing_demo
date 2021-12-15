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

        when(() => loginService.loginWithUsernameAndPassword(any(), any()))
            .thenAnswer((invocation) => Future.value(false));

        when(() => loginService.loginWithUsernameAndPassword(
                'username', 'password'))
            .thenAnswer((invocation) => Future.value(true));
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

      testWidgets('user should login with correct username and password',
          (WidgetTester tester) async {
        // Arrange
        TestScreen testScreen = TestScreen(loginService: loginService);

        verifyNever(() =>
            loginService.loginWithUsernameAndPassword('username', 'password'));

        // Act
        await tester.pumpWidget(
          makeTestableWidget(testScreen),
        );

        await tester.enterText(find.byKey(Key('txt_username')), 'username');
        await tester.enterText(find.byKey(Key('txt_password')), 'password');

        await tester.tap(find.byKey(Key('btn_login')));

        verify(() => loginService.loginWithUsernameAndPassword(
            'username', 'password')).called(1);

        await tester.pump();

        // Assert
        expect(find.byKey(Key('alert_login_success')), findsOneWidget);
      });

      testWidgets('user should fail at login with wrong username and password',
          (WidgetTester tester) async {
        // Arrange
        TestScreen testScreen = TestScreen(loginService: loginService);

        verifyNever(() => loginService.loginWithUsernameAndPassword(
            'wrong-username', 'wrong-password'));

        // Act
        await tester.pumpWidget(
          makeTestableWidget(testScreen),
        );

        await tester.enterText(
            find.byKey(Key('txt_username')), 'wrong-username');
        await tester.enterText(
            find.byKey(Key('txt_password')), 'wrong-password');

        await tester.tap(find.byKey(Key('btn_login')));

        verify(() => loginService.loginWithUsernameAndPassword(
            'wrong-username', 'wrong-password')).called(1);

        await tester.pump();

        // Assert
        expect(find.byKey(Key('alert_login_success')), findsNothing);
        expect(find.byKey(Key('snack_login_failed')), findsOneWidget);
      });
    });
  });
}
