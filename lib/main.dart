import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/welcome_page.dart';
import 'views/widget_tree.dart';
import 'package:flutter_application_1/data/notifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
