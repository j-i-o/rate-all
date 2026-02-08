import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/views/pages/welcome_page.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    initThemeMode();
    super.initState();
  }

  void initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getBool(Constants.lightModeKey);
    isLightModeNotifier.value = themeMode ?? true;

    final accentColor = prefs.getInt(Constants.accentColorKey);
    accentColorNotifier.value = Color(accentColor ?? Colors.amber.toARGB32());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLightModeNotifier,
      builder: (context, isLightMode, child) {
        return ValueListenableBuilder(
          valueListenable: accentColorNotifier,
          builder: (context, accentColor, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: 'SN Pro',
                colorScheme: .fromSeed(
                  seedColor: accentColorNotifier.value,
                  brightness: isLightMode ? Brightness.light : Brightness.dark,
                ),
              ),
              home: WelcomePage(),
            );
          },
        );
      },
    );
  }
}
