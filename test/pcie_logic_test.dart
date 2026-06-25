import 'package:flutter_test/flutter_test.dart';
import 'package:ramspeed/shared/logic.dart';

void main() {
  group('PCIeSpeedLogic', () {
    test('toSpeedStr returns correct numeric value for Gen3 x16', () {
      final s = PCIeSpeedLogic.toSpeedStr(3, 16, isBinaryPrefix: false);
      expect(s, isNotEmpty);
      expect(s, contains('GB/s'));

      final numStr = s.replaceAll(RegExp('[^0-9.]'), '');
      final value = double.parse(numStr);
      expect(value, equals(0.985 * 16));
    });

    test('toSpeedStr returns empty string for null or unknown inputs', () {
      expect(PCIeSpeedLogic.toSpeedStr(null, 16, isBinaryPrefix: false), '');
      expect(PCIeSpeedLogic.toSpeedStr(3, null, isBinaryPrefix: false), '');
      expect(PCIeSpeedLogic.toSpeedStr(0, 1, isBinaryPrefix: false), '');
    });

    test('toSpeedStr formats output with two decimals', () {
      final s = PCIeSpeedLogic.toSpeedStr(
        7,
        1,
        isBinaryPrefix: false,
      ); // 15.125 -> should format
      final numStr = s.replaceAll(RegExp('[^0-9.]'), '');
      final parts = numStr.split('.');
      expect(parts.length, equals(2));
      expect(parts[1].length, equals(2));
    });
  });
}
