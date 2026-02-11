import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/app_user.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/views/widgets/floating_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/views/pages/new_category.dart';

class ListadoPage extends ConsumerStatefulWidget {
  const ListadoPage({super.key});

  @override
  ConsumerState<ListadoPage> createState() => _ListadoPageState();
}

class _ListadoPageState extends ConsumerState<ListadoPage> {
  final DatabaseService _db = DatabaseService();
  List<Category> categoriesFetched = [];
  bool _loaded = false;

  void _loadData(AppUser user) async {
    setState(() {
      _loaded = false;
    });
    final items = await _db.getMainCategories(user);
    setState(() {
      categoriesFetched = items;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final accentColor = ref.watch(accentColorProvider);

    return authAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (user) {
        if (!_loaded) {
          _loadData(user!);
          return const Center(child: CircularProgressIndicator());
        }

        Widget content;

        if (categoriesFetched.isEmpty) {
          content = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No hay categorias creadas'),
                SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: accentColor),
                  child: Text('Crear categoria'),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewCategory()),
                    );
                    if (result != null) {
                      _loadData(user!);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          content = RefreshIndicator(
            color: accentColor,
            onRefresh: () async => _loadData(user!),
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: categoriesFetched.map((category) {
                return CategoryCard(
                  category: category,
                  onMainCategoryChanged: () => _loadData(user!),
                );
              }).toList(),
            ),
          );
        }

        return Stack(
          children: [
            content,
            Positioned(
              bottom: 45,
              right: 30,
              child: FloatingButtonWidget(
                newItem: false,
                onCreated: () => _loadData(user!),
              ),
            ),
          ],
        );
      },
    );
  }
}
