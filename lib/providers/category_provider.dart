import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final db = DatabaseService();
  final user = ref.watch(authProvider).value;

  if (user == null) return [];

  return db.getMainCategories(user);
});
