import 'package:flutter_application_1/models/base_item.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsProvider = FutureProvider.family<List<BaseItem>, Category>((ref, category) async {
  final db = DatabaseService();
  final user = ref.watch(authProvider).value!;

  return db.getItems(category, user);
});