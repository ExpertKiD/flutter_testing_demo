import 'package:flutter_test/flutter_test.dart';
import 'package:testingdemo/models/counter.dart';

void main() {
  group('Counter tests', () {
    test('Counter should be 0', () {
      expect(Counter().value, 0);
    });

    test('Counter value should be incremented by 1', () {
      //Arrange
      final counter = Counter();
      int initialValue = counter.value;

      //Act
      counter.increment();

      //Assert
      expect(counter.value, initialValue + 1);
    });

    test('Counter value should be decremented by 1', () {
      //Arrange
      final counter = Counter();
      int initialValue = counter.value;

      //Act
      counter.decrement();

      //Assert
      expect(counter.value, initialValue - 1);
    });
  });
}
