import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/light_mode_provider.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/views/pages/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode = ref.watch(lightModeProvider);

    return Drawer(
      backgroundColor: ref.watch(accentColorProvider),
      child: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.only(top: 25, right: 10, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'RateAll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.star_rounded, color: Colors.white, size: 50),
                  ],
                ),
                Text(ref.watch(authProvider).value!.email, style: TextStyle(color: Colors.white, fontSize: 30)),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Listado',
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            onTap: () async {
              AuthService.signOut();
            },
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 20.0,
              children: [
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  iconSize: 40,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                      isLightMode ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool(Constants.lightModeKey, !isLightMode);
                      ref.read(lightModeProvider.notifier).setLightMode(!isLightMode);
                    },
                    iconSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
