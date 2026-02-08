import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_application_1/views/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return ValueListenableBuilder(
          valueListenable: accentColorNotifier,
          builder: (context, accentColor, child) {
            return Drawer(
              backgroundColor: accentColor,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(
                      top: 25,
                      right: 10,
                      bottom: 40,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
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
                          Icon(
                            Icons.star_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Listado',
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    onTap: () {
                      selectedPageNotifier.value = 0;
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Items',
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    onTap: () {
                      selectedPageNotifier.value = 1;
                      Navigator.pop(context);
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
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            );
                          },
                          iconSize: 40,
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 20),
                          child: ValueListenableBuilder(
                            valueListenable: isLightModeNotifier,
                            builder: (context, isLightMode, child) {
                              return IconButton(
                                icon: Icon(
                                  isLightMode ? Icons.dark_mode : Icons.sunny,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  isLightModeNotifier.value = !isLightMode;
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool(
                                      Constants.lightModeKey, isLightModeNotifier.value);
                                },
                                iconSize: 40,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
