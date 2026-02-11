import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/app_user.dart';
import 'package:flutter_application_1/models/base_item.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/services/database.dart';
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
  final DatabaseService _db = DatabaseService();
  List<BaseItem> items = [];
  bool _loaded = false;

  void _loadData(AppUser user) async {
    final items = await _db.getItems(widget.category, user);
    setState(() {
      this.items = items;
      _loaded = true;
    });
  }

  //Al ingresar a esta pagina hay q traer todos los items de la categoría en donde nos metimos
  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final accentColor = ref.watch(accentColorProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: widget.category.color,
        title: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(widget.category.icono, size: 50, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  widget.category.nombre,
                  style: TextStyle(fontSize: 40, color: Colors.white),
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
                      widget.category.children.toString(),
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

      body: authAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (user) {
          if (!_loaded) {
            _loadData(user!);
            return const Center(child: CircularProgressIndicator());
          }
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewItem(category: widget.category),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            content = ListView(
              padding: const EdgeInsets.all(10),
              children: items.map((i) {
                if (i is Item) {
                  return ItemCard(item: i);
                } else if (i is Category) {
                  return CategoryCard(category: i);
                }
                return const SizedBox.shrink();
              }).toList(),
            );
          }

          return Stack(
            children: [
              content,
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingButtonWidget(
                  newItem: true,
                  category: widget.category,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
