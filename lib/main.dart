import 'package:flutter/material.dart';
import './screens/calendar_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './provider/theme_provider.dart';
import './utils.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appThemes = ref.watch(themesProvider);

    for (int i = 0; i < appThemes.length; i++) {
      if (appThemes[i]['isSelected']) {
        selectedAppTheme = appThemes[i];
      }
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 30,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
            )),
        colorScheme: ColorScheme.fromSeed(
            seedColor: selectedAppTheme['primary'],
            primary: selectedAppTheme['primaryLight'],
            secondary: selectedAppTheme['primaryDark']),
      ),
      home: const CalendarScreen(),
    );
  }
}
