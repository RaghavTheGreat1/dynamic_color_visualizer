import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dynamic_color_mode_provider.dart';
import '../../../providers/picker_color_provider.dart';

class ColorPickerCard extends ConsumerWidget {
  const ColorPickerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Color Picker",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final color = ref.watch(pickerColorProvider);
            return ColorPicker(
              color: color,
              enableOpacity: true,
              opacityTrackHeight: 10,
              pickersEnabled: const {
                ColorPickerType.wheel: true,
              },
              onColorChanged: (value) {
                ref.read(dynamicColorModeProvider.notifier).state =
                    DynamicColorMode.color;
                ref.read(pickerColorProvider.notifier).state = value;
              },
            );
          },
        ),
      ],
    );
  }
}
