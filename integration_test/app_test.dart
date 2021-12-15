import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testingdemo/main_test.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration tests', () {
    testWidgets(
        'Test Screen -> Fill credentials -> Hit Login and Success Login',
        (tester) async {
      // Arrange
      app.main();
      await tester.pump();

      final usernameTextField = find.byKey(const Key('txt_username'));
      final passwordTextField = find.byKey(const Key('txt_password'));

      // Act
      await tester.enterText(usernameTextField, 'username');
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      await tester.enterText(passwordTextField, 'password');
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      final loginBtn = find.byKey(Key('btn_login'));
      assert(loginBtn != null, "Login button can't be null here");

      await tester.tap(loginBtn);

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Assert
      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('Test Screen -> Fill credentials -> Hit Login and Fail',
        (tester) async {
      // Arrange
      app.main();
      await tester.pump();

      final usernameTextField = find.byKey(const Key('txt_username'));
      final passwordTextField = find.byKey(const Key('txt_password'));

      // Act
      await tester.enterText(usernameTextField, 'wrong-username');
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.enterText(passwordTextField, 'wrong-password');
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.tap(find.byKey(Key('btn_login')));

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
