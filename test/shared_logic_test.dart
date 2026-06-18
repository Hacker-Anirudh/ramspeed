import 'package:flutter_test/flutter_test.dart';
import 'package:ramspeed/shared/logic.dart';

void main() {
  group('RamSpeedLogic', () {
    test('onGo returns correct speed and latency for valid inputs', () async {
      final (latencyStr, speedStr) = await RamSpeedLogic.onGo(
        '3200',
        '64',
        '2',
        '16',
      );

      expect(latencyStr, 'Total latency: 10.00 ns');
      expect(speedStr, isNotNull);
      expect(speedStr, contains('GB/s'));
      expect(speedStr, contains('51.2'));
    });

    test(
      'onGo returns null speed and empty latency for invalid mt input',
      () async {
        final (latencyStr, speedStr) = await RamSpeedLogic.onGo(
          'abc',
          '64',
          '2',
          '16',
        );

        expect(latencyStr, '');
        expect(speedStr, isNull);
      },
    );

    test('onGo parses CAS with non-digit characters', () async {
      final (latencyStr, speedStr) = await RamSpeedLogic.onGo(
        '3000',
        '64',
        '2',
        '16a',
      );

      // '16a' should be parsed as 16
      final expectedLatency = (16 * (2000 / 3000)).toStringAsFixed(2);
      expect(latencyStr, 'Total latency: $expectedLatency ns');
      expect(speedStr, isNotNull);
    });
  });
}
