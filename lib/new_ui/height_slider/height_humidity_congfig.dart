class HumidityConfigH {
  HumidityConfigH(int minValue, int maxValue) {
    firstActiveIndex = list.indexWhere((n) => n >= minValue);
    lastActiveIndex = list.lastIndexWhere((n) => n <= maxValue);
  }

  int firstActiveIndex;
  int lastActiveIndex;

  final paddingTopInPercentage = 13.3;
  final paddingBottomInPercentage = 11.2;

  final List<int> list = const [
    80,
    100,
    120,
    140,
    160,
    180,
    200,
    220,
  ];
}

double kNumberFontSize = 18;
