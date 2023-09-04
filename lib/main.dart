import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_visualizer/providers/theme_mode_provider.dart';
import 'package:dynamic_color_visualizer/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/color_schemes_provider.dart';

void main() {
  Animate.restartOnHotReload = true;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final colorSchemes = ref.watch(colorSchemesProvider).value;

    return DynamicColorBuilder(
      builder: (lightScheme, darkScheme) {
        final lightTheme = ThemeData(
          useMaterial3: true,
          colorScheme: colorSchemes?.light ?? lightScheme,
        );
        final darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: colorSchemes?.dark ?? darkScheme,
        );

        return MaterialApp(
          title: 'Dynamic Color Visualizer',
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
