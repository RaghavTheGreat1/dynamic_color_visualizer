import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DynamicColorMode {
  device,
  color,
  image,
}

final dynamicColorModeProvider = StateProvider<DynamicColorMode>((ref) {
  return DynamicColorMode.device;
});
