import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: accentColorNotifier,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          initialValue: accentColorNotifier.value,
                          items: [
                            DropdownMenuItem(
                              value: Colors.amber,
                              child: Text('Amarillo'),
                            ),
                            DropdownMenuItem(
                              value: Colors.blue[600],
                              child: Text('Azul'),
                            ),
                            DropdownMenuItem(
                              value: Colors.red[600],
                              child: Text('Rojo'),
                            ),
                          ],
                          onChanged: (colorSelected) async {
                            accentColorNotifier.value = colorSelected!;
                            final prefs = await SharedPreferences.getInstance();
                            print(colorSelected.toARGB32());
                            await prefs.setInt(Constants.accentColorKey, colorSelected.toARGB32());
                          },
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
