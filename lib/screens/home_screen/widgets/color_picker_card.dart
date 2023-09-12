import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dynamic_color_mode_provider.dart';
import '../../../providers/picker_color_provider.dart';

class ColorPickerCard extends ConsumerStatefulWidget {
  const ColorPickerCard({super.key});

  @override
  ConsumerState<ColorPickerCard> createState() => _ColorPickerCardState();
}

class _ColorPickerCardState extends ConsumerState<ColorPickerCard> {
  final colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(pickerColorProvider, (previous, next) {
      colorController.text = next.hex;
    });
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
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: theme.colorScheme.surfaceVariant,
          ),
          child: TextField(
            controller: colorController,
            onChanged: (value) {
              value = value.replaceAll(RegExp(r"#"), "");
              if (value.length == 6) {
                ref.read(dynamicColorModeProvider.notifier).state =
                    DynamicColorMode.color;
                ref.read(pickerColorProvider.notifier).state =
                    Color(int.parse("0xFF$value"));
              }
            },
            cursorColor: theme.colorScheme.onSurfaceVariant,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            decoration: InputDecoration(
              hintText: "Hex Code",
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
              iconColor: theme.colorScheme.onSurfaceVariant,
              border: InputBorder.none,
              fillColor: theme.colorScheme.surfaceVariant,
              prefixIcon: Icon(
                Icons.color_lens_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
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
