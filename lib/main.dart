import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'router.dart';
import 'providers.dart';
import 'providers/theme_provider.dart';
import 'providers/shared_preferences_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: ToastificationConfig(
        alignment: Alignment.bottomCenter,
        maxToastLimit: 1,
      ),
      child: MultiProvider(
        providers: providers,
        child: Consumer2<SharedPreferencesProvider, ThemeProvider>(
          builder: (context, sharedPreferencesProvider, themeProvider, child) {
            sharedPreferencesProvider.loadSettings();
            return MaterialApp.router(
              title: 'Nourish App',
              themeMode: themeProvider.themeMode,
              theme: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              darkTheme: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              routerConfig: router,
              builder: (context, child) => child!,
            );
          },
        ),
      ),
    );
  }
}