import 'package:dynamic_color_visualizer/providers/dynamic_scheme_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dynamic_color_mode_provider.dart';
import 'picker_color_provider.dart';
import 'picker_image_provider.dart';

final colorSchemesProvider =
    FutureProvider<({ColorScheme? light, ColorScheme? dark})>((ref) {
  final dynamicSchemeVariant = ref.watch(dynamicSchemeVariantProvider);
  final image = ref.watch(pickerImageProvider).value;
  final mode = ref.watch(dynamicColorModeProvider);
  if (image != null && mode == DynamicColorMode.image) {
    final colorSchemes = ref.watch(colorSchemeProvider(image)).value;
    if (colorSchemes == null) {
      return (light: null, dark: null);
    }
    return (light: colorSchemes.light, dark: colorSchemes.dark);
  }

  if (mode == DynamicColorMode.color) {
    final color = ref.watch(pickerColorProvider);
    final light = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.light,
      dynamicSchemeVariant: dynamicSchemeVariant,
    );
    final dark = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
      dynamicSchemeVariant: dynamicSchemeVariant,
    );
    return (light: light, dark: dark);
  }
  return (light: null, dark: null);
});

final colorSchemeProvider =
    FutureProvider.family<({ColorScheme light, ColorScheme dark}), Image>(
        (ref, image) async {
  final dynamicSchemeVariant = ref.watch(dynamicSchemeVariantProvider);

  final light = await ColorScheme.fromImageProvider(
    provider: image.image,
    brightness: Brightness.light,
    dynamicSchemeVariant: dynamicSchemeVariant,
  );
  final dark = await ColorScheme.fromImageProvider(
    provider: image.image,
    brightness: Brightness.dark,
    dynamicSchemeVariant: dynamicSchemeVariant,
  );

  return (light: light, dark: dark);
});
