class RamSpeedLogic {
  static String? _toRAMSpeed(
    String mt,
    String bus,
    String channels,
    bool isBinaryPrefix,
  ) {
    final mttemp = double.tryParse(mt);
    final bustemp = double.tryParse(bus);
    final channelstemp = double.tryParse(channels);
    if (mttemp == null ||
        bustemp == null ||
        channelstemp == null ||
        mttemp <= 0) {
      return null;
    }
    final tempval = (mttemp * bustemp * channelstemp) / 8;
    if (tempval < 1000) {
      double mbVal = 0;
      if (isBinaryPrefix) {
        mbVal = tempval * 0.953674316;
      }
      final tempvalString = mbVal.toStringAsFixed(2);
      return 'Speed: $tempvalString MB/s';
    } else if (tempval < 1000000) {
      var gbVal = tempval / 1000;
      if (isBinaryPrefix) {
        gbVal = gbVal * 0.953674316;
      }
      final rvalString = gbVal.toStringAsFixed(2);
      return 'Speed: $rvalString GB/s';
    } else {
      var tbVal = tempval / 1000000;
      if (isBinaryPrefix) {
        tbVal = tbVal * 0.953674316;
      }
      final rvalString = tbVal.toStringAsFixed(2);
      return 'Speed: $rvalString TB/s';
    }
  }

  static String _toLatencyStr(String casinput, String mtinput) {
    final castemp = casinput.replaceAll(RegExp('[^0-9]'), '');

    final mt = double.tryParse(mtinput);
    final cas = double.tryParse(castemp);

    if (mt == null || cas == null || mt <= 0) {
      return '';
    } else {
      final latency = cas * (2000 / mt);
      return 'Total latency: ${latency.toStringAsFixed(2)} ns';
    }
  }

  static Future<(String, String?)> onGo(
    String mtController,
    String busController,
    String channelController,
    String casController, {
    required bool isBinaryPrefix,
  }) async {
    final result = _toRAMSpeed(
      mtController,
      busController,
      channelController,
      isBinaryPrefix,
    );
    final latencyStr = _toLatencyStr(
      casController,
      mtController,
    );
    return (latencyStr, result);
  }
}

class PCIeSpeedLogic {
  // Speeds are from Wikipedia, may or may not be 100% accurate
  static final Map<int, double> _busSpeedbyGen = {
    1: 0.25,
    2: 0.5,
    3: 0.985,
    4: 1.969,
    5: 3.938,
    6: 7.563,
    7: 15.125,
  };

  static String toSpeedStr(int? gen, int? lanes) {
    final speed = _busSpeedbyGen[gen];
    if (speed == null || lanes == null) return '';
    final totalSpeed = (speed * lanes).toStringAsFixed(2);
    final string = '$totalSpeed GB/s';
    return string;
  }
}
