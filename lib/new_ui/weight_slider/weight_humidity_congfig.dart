class HumidityConfigW {
  HumidityConfigW(int minValue, int maxValue) {
    firstActiveIndex = list.indexWhere((n) => n >= minValue);
    lastActiveIndex = list.lastIndexWhere((n) => n <= maxValue);
  }

  int firstActiveIndex;
  int lastActiveIndex;

  final paddingTopInPercentage = 13.3;
  final paddingBottomInPercentage = 11.2;

  final List<int> list = const [
    20,
    40,
    60,
    80,
    100,
    120,
    140,
    160,
  ];
}

double kNumberFontSize = 18;
