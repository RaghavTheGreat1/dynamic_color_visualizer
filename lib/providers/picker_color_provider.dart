import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pickerColorProvider = StateProvider<Color>((ref) {
  return Colors.blue;
});
