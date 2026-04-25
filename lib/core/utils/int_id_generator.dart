class IntIdGenerator {
  static int _lastTimestamp = 0;
  static int _counter = 0;

  static int generate() {
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now == _lastTimestamp) {
      _counter++;
    } else {
      _lastTimestamp = now;
      _counter = 0;
    }

    return now * 1000 + _counter;
  }
}
