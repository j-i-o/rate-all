import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/light_mode_provider.dart';
import 'package:flutter_application_1/views/pages/authenticate/welcome_page.dart';
import 'package:flutter_application_1/views/widget_tree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/models/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode = ref.watch(lightModeProvider);
    final accentColor = ref.watch(accentColorProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SN Pro',
        colorScheme: .fromSeed(
          seedColor: accentColor,
          brightness: isLightMode ? Brightness.light : Brightness.dark,
        ),
      ),
      home: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<AppUser?> user = ref.watch(authProvider);
          return user.when(
            data: (value) {
              if (value == null) {
                return const WelcomePage();
              }
              return const WidgetTree();
            },
            error: (error, _) => const Text('Error loading auth status'),
            loading: () => const Text('Loading...'),
          );
        },
      ),
    );
  }
}
