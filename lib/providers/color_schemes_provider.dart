import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'picker_image_provider.dart';

final colorSchemesProvider =
    FutureProvider<({ColorScheme? light, ColorScheme? dark})>((ref) {
  final image = ref.watch(pickerImageProvider).value;
  if (image != null) {
    final colorSchemes = ref.watch(colorSchemeProvider(image)).value;
    if (colorSchemes == null) {
      return (light: null, dark: null);
    }
    return (light: colorSchemes.light, dark: colorSchemes.dark);
  }
  return (light: null, dark: null);
});

final colorSchemeProvider =
    FutureProvider.family<({ColorScheme light, ColorScheme dark}), Image>(
        (ref, image) async {
  final light = await ColorScheme.fromImageProvider(
    provider: image.image,
    brightness: Brightness.light,
  );
  final dark = await ColorScheme.fromImageProvider(
    provider: image.image,
    brightness: Brightness.dark,
  );

  return (light: light, dark: dark);
});
