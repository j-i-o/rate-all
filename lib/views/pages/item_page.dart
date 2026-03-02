import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/models/item_sort.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/providers/item_sort_provider.dart';
import 'package:flutter_application_1/providers/sorted_items_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/views/pages/new_category.dart';
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
  bool showFilter = false;
  final db = DatabaseService();

  @override
  void initState() {
    super.initState();
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(sortedItemsProvider(_category));
    final accentColor = ref.watch(accentColorProvider);
    final currentSort = ref.watch(itemSortProvider);
    final items = itemAsync.asData?.value ?? [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 25,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        toolbarHeight: showFilter ? 200 : 150,
        backgroundColor: _category.color,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
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
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewCategory(categoryToEdit: widget.category),
                    ),
                  ),
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
                IconButton(
                  iconSize: 25,
                  onPressed: () => setState(() => showFilter = !showFilter),
                    icon: Icon(Icons.swap_vert_rounded, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AnimatedContainer(
            color: Colors.white24,
            duration: const Duration(milliseconds: 200),
            height: showFilter ? 56 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: showFilter
                ? Row(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              [
                                ItemSort.nameDesc,
                                ItemSort.nameAsc,
                              ].contains(currentSort)
                              ? Colors.black26
                              : null,
                        ),
                        onPressed: () => ref
                            .read(itemSortProvider.notifier)
                            .setSort(
                              currentSort == ItemSort.nameAsc
                                  ? ItemSort.nameDesc
                                  : ItemSort.nameAsc,
                            ),
                        icon: Row(
                          children: [
                            Icon(Icons.abc_rounded, color: Colors.white),
                            Icon(
                              currentSort == ItemSort.nameAsc
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              [
                                ItemSort.updatedDesc,
                                ItemSort.updatedAsc,
                              ].contains(currentSort)
                              ? Colors.black26
                              : null,
                        ),
                        onPressed: () => ref
                            .read(itemSortProvider.notifier)
                            .setSort(
                              currentSort == ItemSort.updatedAsc
                                  ? ItemSort.updatedDesc
                                  : ItemSort.updatedAsc,
                            ),
                        icon: Row(
                          children: [
                            Icon(Icons.update_rounded, color: Colors.white),
                            Icon(
                              currentSort == ItemSort.updatedAsc
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              [
                                ItemSort.ratingDesc,
                                ItemSort.ratingAsc,
                              ].contains(currentSort)
                              ? Colors.black26
                              : null,
                        ),
                        onPressed: () => ref
                            .read(itemSortProvider.notifier)
                            .setSort(
                              currentSort == ItemSort.ratingAsc
                                  ? ItemSort.ratingDesc
                                  : ItemSort.ratingAsc,
                            ),
                        icon: Row(
                          children: [
                            Icon(Icons.star_rounded, color: Colors.white),
                            Icon(
                              currentSort == ItemSort.ratingAsc
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        iconSize: 25,
                        onPressed: () => setState(() => showFilter = false),
                        icon: Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  )
                : null,
          ),
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
                    return ItemCard(
                      item: i,
                      color: _category.color,
                      parentCategory: _category,
                    );
                  } else if (i is Category) {
                    return CategoryCard(category: i, parentCategory: _category);
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
