import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/constants.dart';

class AccentColorNotifier extends Notifier<Color> {

  @override
  Color build() {
    _loadFromPrefs();
    return Colors.amber;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getInt(Constants.accentColorKey);

    if (stored != null) {
      state = Color(stored);
    }
  }

  Future<void> setColor(Color color) async {
    state = color;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      Constants.accentColorKey,
      color.toARGB32(),
    );
  }
}

final accentColorProvider =
    NotifierProvider<AccentColorNotifier, Color>(
  AccentColorNotifier.new,
);
