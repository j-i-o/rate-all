import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/views/pages/new_item.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';
import 'package:flutter_application_1/views/widgets/item_card.dart';
import 'package:flutter_application_1/views/widgets/floating_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemPage extends ConsumerStatefulWidget {
  const ItemPage({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends ConsumerState<ItemPage> {
  late Category _category;

  @override
  void initState() {
    super.initState();
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(itemsProvider(_category));
    final accentColor = ref.watch(accentColorProvider);
    final items = itemAsync.asData?.value ?? [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 25,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        toolbarHeight: 150,
        backgroundColor: _category.color,
        title: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 5,
              children: [
                Icon(_category.icono, size: 50, color: Colors.white),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _category.nombre,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      items.length.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(Icons.remove_red_eye_rounded, color: Colors.white),
                  ],
                ),
                Spacer(),
                IconButton(
                  iconSize: 25,
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),

      body: itemAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (items) {
          Widget content;

          if (items.isEmpty) {
            content = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No hay items creados'),
                  SizedBox(height: 20),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: accentColor),
                    child: Text('Crear item'),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewItem(category: _category),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            content = RefreshIndicator(
              color: accentColor,
              onRefresh: () async => ref.invalidate(itemsProvider(_category)),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: items.map((i) {
                  if (i is Item) {
                    return ItemCard(item: i, color: _category.color);
                  } else if (i is Category) {
                    return CategoryCard(category: i);
                  }
                  return const SizedBox.shrink();
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
                  newItem: true,
                  category: _category,
                  onCreated: () {
                    ref.invalidate(itemsProvider(_category), asReload: true);
                    ref.invalidate(categoriesProvider, asReload: true);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
