import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  static const Color amber = Colors.amber;
  static const Color blue = Color(0xFF1E88E5);
  static const Color red = Color(0xFFE53935);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = ref.watch(accentColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedColor,
                      items: [
                        DropdownMenuItem(value: amber, child: Text('Amarillo')),
                        DropdownMenuItem(value: blue, child: Text('Azul')),
                        DropdownMenuItem(value: red, child: Text('Rojo')),
                      ],
                      onChanged: (color) async {
                        if (color == null) return;
                        ref.read(accentColorProvider.notifier).setColor(color);
                      },
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
