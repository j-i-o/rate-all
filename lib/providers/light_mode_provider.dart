import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/constants.dart';

class LightModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadFromPrefs();
    return true;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getBool(Constants.lightModeKey);

    if (stored != null) {
      state = stored;
    }
  }

  Future<void> setLightMode(bool value) async {
    state = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.lightModeKey, value);
  }
}

final lightModeProvider = NotifierProvider<LightModeNotifier, bool>(
  LightModeNotifier.new,
);
