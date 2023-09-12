import 'package:dynamic_color_visualizer/responsive/responsive_builder.dart';
import 'package:dynamic_color_visualizer/screens/home_screen/widgets/color_picker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

import '../../providers/theme_mode_provider.dart';
import '../color_palette_screen.dart';
import 'widgets/dynamic_color.dart';
import 'widgets/image_picker_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Image(
          height: 24,
          image: AssetImage(
            "assets/icon/logo.png",
          ),
        ),
        leading: ResponsiveBuilder(
          mobile: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          ResponsiveBuilder(
            desktop: (context) {
              return const _DarkModeSwitch();
            },
            tablet: (context) {
              return const _DarkModeSwitch();
            },
          ),
        ],
      ),
      drawer: ResponsiveBuilder(
        mobile: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const _DarkModeSwitch(),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      UniconsLine.times,
                    ),
                  ),
                )
              ],
            ),
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: _ColorConfiguration(),
              ),
            ),
          );
        },
      ),
      body: Row(
        children: [
          ResponsiveBuilder(
            desktop: (context) {
              return const SizedBox(
                width: 256,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _ColorConfiguration(),
                ),
              );
            },
            tablet: (context) {
              return const SizedBox(
                width: 256,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _ColorConfiguration(),
                ),
              );
            },
          ),
          ResponsiveBuilder(
            desktop: (context) {
              return const VerticalDivider();
            },
            tablet: (context) {
              return const VerticalDivider();
            },
          ),
          const ColorPalettesScreen(),
        ],
      ),
    );
  }
}

class _DarkModeSwitch extends StatelessWidget {
  const _DarkModeSwitch();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Dark Mode",
        ),
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
    );
  }
}

class _ColorConfiguration extends StatelessWidget {
  const _ColorConfiguration();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            DynamicColorModeSelector(),
            SizedBox(
              height: 16,
            ),
            ImagePickerCard(),
            SizedBox(
              height: 16,
            ),
            ColorPickerCard(),
          ],
        ),
      ),
    );
  }
}
