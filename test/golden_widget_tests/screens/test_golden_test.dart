import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testingdemo/screens/test.dart';
import 'package:testingdemo/services/login_service.dart';

import '../../mocks/services/login_service_mock.dart';
import '../../utils.dart';

void main() {
  group("Test Screen Golden test", () {
    late LoginService loginService;

    // Setup mock dependencies before each test
    setUp(() {
      // Mock here
      loginService = MockLoginService();
    });

    tearDown(() {
      // clear mock here
      reset(loginService);
    });
    testWidgets('test screen', (WidgetTester tester) async {
      TestScreen testScreen = TestScreen(loginService: loginService);

      await tester.pumpWidget(makeTestableWidget(testScreen));

      await expectLater(
          find.byType(TestScreen),
          matchesGoldenFile('../generated/screens/test_screen.png',
              version: 1));
    });
  });
}
