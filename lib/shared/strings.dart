class Strings {
  static const String appName = 'RAMSpeed';
  static const String legalese =
      '(c) 2020-2026 Anirudh Menon. GNU GPL v3 license. All rights reserved.\nFor feature suggestions/bug reports, open an issue on Github.';
  static const String appVersion = '1.3.2';
  static const String memeSpeed = 'Speed: 6967 YB/s';
}

class BodyStrings {
  static const String dataEntry = 'Enter the following data:';
  static const String speed = 'Speed (MT/s)';
  static const String busWidth = 'Bus width';
  static const String channels = 'Channels';
  static const String cas =
      'To calculate the latency, enter the CAS latency (e.g. CL30):';
  static const String casDecoration = 'CAS latency';
  static const String go = 'Go!';
}

class DialogStrings {
  static const String q = 'How do I find this info?';
  static const String mt = 'MT/s (MegaTransfers per second)';
  static const String mtExplanation =
      'Bus speed. Typically a prominent specification, sometimes also shown as, for example, DDR5-6400. This would mean 6400 MT/s.';
  static const String bus = 'Bus Width';
  static const String busExplanation =
      'Typically 64-bit for PCs, 16-bit for smartphones '
      'and derivatives (for example Apple M-series silicon).';
  static const String channels = 'Number of Channels';
  static const String channelsExplanation =
      'Can usually be found online. '
      '(Or on a PC, check hardware info software.)';
  static const String cas = 'CAS Latency';
  static const String casExplanation =
      'Also usually a prominent specification on PC RAM, '
      'but is very rarely found in specs of other devices.';
  static const String gotit = 'Got it';
  static const String error = 'Error';
  static const String ok = 'OK';
  static const String invalidInput = 'Make sure your inputs are valid.';
}

class PCIeStrings {
  static const String gen = 'PCI Express generation';
  static const String lanes = 'Lanes';
  static const String computedSpeed = 'Speed:';
  static const String selGen = 'Select PCIe generation';
  static const String selLanes = 'Select number of lanes';
  static const String sel = 'Select';
  static const String done = 'Done';
}
