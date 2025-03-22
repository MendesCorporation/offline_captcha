import 'dart:math';
import 'package:flutter/foundation.dart';

class CaptchaController extends ValueNotifier<(String, int)> {
  final int _length;
  final _random = Random();

  CaptchaController({int length = 6}) : 
    _length = length.clamp(1, 12),
    super(('', 0)) {
    regenerate();
  }

  String get code => value.$1;
  int get seed => value.$2;
  int get length => _length;

  void regenerate() {
    value = (
      List.generate(_length, (_) => _random.nextInt(10)).join(),
      _random.nextInt(1000000)
    );
  }

  bool validate(String input) {
    return input == code;
  }
}
