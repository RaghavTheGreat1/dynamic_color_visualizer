import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dynamic_color_mode_provider.dart';

class DynamicColorModeSelector extends ConsumerWidget {
  const DynamicColorModeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SizedBox(
      child: SegmentedButton(
        showSelectedIcon: false,
        segments: List.generate(
          DynamicColorMode.values.length,
          (index) => ButtonSegment(
            value: DynamicColorMode.values[index],
            label: Text(
              DynamicColorMode.values[index].name.toUpperCase(),
              style: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        onSelectionChanged: (p0) {
          ref.read(dynamicColorModeProvider.notifier).state = p0.first;
        },
        selected: {
          ref.watch(dynamicColorModeProvider),
        },
      ),
    );
  }
}
