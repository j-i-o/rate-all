import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';
import 'package:flutter_application_1/views/widgets/floating_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/views/pages/new_category.dart';

class ListadoPage extends ConsumerStatefulWidget {
  const ListadoPage({super.key});

  @override
  ConsumerState<ListadoPage> createState() => _ListadoPageState();
}

class _ListadoPageState extends ConsumerState<ListadoPage> {
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final accentColor = ref.watch(accentColorProvider);

    return categoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (categories) {
        Widget content;

        if (categories.isEmpty) {
          return Center(
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
                    if (result == true) {
                      ref.invalidate(categoriesProvider);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          content = RefreshIndicator(
            color: accentColor,
            onRefresh: () async => ref.invalidate(categoriesProvider),
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: categories.map((category) {
                return CategoryCard(category: category);
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
              child: FloatingButtonWidget(newItem: false),
            ),
          ],
        );
      },
    );
  }
}
