import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_visualizer/providers/theme_mode_provider.dart';
import 'package:dynamic_color_visualizer/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  Animate.restartOnHotReload = true;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return DynamicColorBuilder(
      builder: (lightScheme, darkScheme) {
        final lightTheme = ThemeData(
          useMaterial3: true,
        );
        final darkTheme = ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
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
