import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_mode_provider.dart';
import 'color_palette_screen.dart';
import 'home_screen/widgets/image_picker_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Color Visualizer'),
        actions: [
          Row(
            children: [
              const Text("Dark Mode"),
              Consumer(
                builder: (context, ref, _) {
                  final value = ref.watch(themeModeProvider);
                  return Switch.adaptive(
                    value: value == ThemeMode.dark ? true : false,
                    onChanged: (value) {
                      ref.read(themeModeProvider.notifier).state =
                          value ? ThemeMode.dark : ThemeMode.light;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: const Row(
        children: [
          SizedBox(
            width: 256,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImagePickerCard(),
                ],
              ),
            ),
          ),
          VerticalDivider(),
          ColorPalettesScreen(),
        ],
      ),
    );
  }
}
