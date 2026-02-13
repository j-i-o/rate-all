import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/views/pages/item_page.dart';
import 'package:flutter_application_1/views/pages/new_category.dart';
import 'package:flutter_application_1/views/widgets/swipeable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({super.key, required this.category, this.parentCategory});

  final Category category;
  final Category? parentCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _db = DatabaseService();

    return SwipeableCard(
      key: ValueKey(category.uid),
      categoryStyle: true,
      onEdit: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewCategory(categoryToEdit: category, parentCategory: parentCategory)),
      ),
      onDelete: () async {
        //TODO: Actualizar db pero borrar localmente para ahorrar salidas
        await _db.deleteBaseItem(category);
        if (parentCategory != null) {
          ref.invalidate(itemsProvider(parentCategory!), asReload: true);
        } else {
          ref.invalidate(categoriesProvider, asReload: true);
        }
      },
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemPage(category: category)),
      ),
      child: Card(
        color: category.color,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(category.icono, size: 50, color: Colors.white),
                title: Text(
                  category.nombre,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category.children.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Icon(Icons.remove_red_eye_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
