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
  bool showDescription = false;
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
      body: Stack(
        children: [
          RefreshIndicator(
            color: _category.color,
            onRefresh: () async => ref.invalidate(itemsProvider(_category)),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  leading: IconButton(
                    iconSize: 25,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  expandedHeight: 100,
                  backgroundColor: _category.color,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 72, bottom: 16, right: 16),
                    title: Row(
                      children: [
                        Icon(_category.icono, size: 36, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _category.nombre,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => showDescription = !showDescription),
                    child: widget.category.descripcion!.isEmpty
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            color: _category.color,
                            child: Text(
                              widget.category.descripcion ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                overflow: showDescription
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _FilterHeaderDelegate(
                    minHeight: 50,
                    maxHeight: 50,
                    child: Container(
                      color: _category.color,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                items.length.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Items',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              // Icon(
                              //   Icons.remove_red_eye_rounded,
                              //   color: Colors.white,
                              // ),
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
                            onPressed: () =>
                                setState(() => showFilter = !showFilter),
                            icon: Icon(
                              showFilter
                                  ? Icons.filter_list_off
                                  : Icons.filter_list,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _FilterHeaderDelegate(
                    minHeight: showFilter ? 60 : 0,
                    maxHeight: showFilter ? 60 : 0,
                    child: Container(
                      color: _category.color,
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            onPressed: () => setState(() {
                              showFilter = false;
                              ref
                                  .read(itemSortProvider.notifier)
                                  .setSort(ItemSort.nameAsc);
                            }),
                            icon: Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 10)),
                itemAsync.when(
                  loading: () => SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(color: _category.color)),
                  ),
                  error: (error, stackTrace) => SliverToBoxAdapter(
                    child: Center(child: Text('Error: $error')),
                  ),
                  data: (items) {
                    if (items.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 150),
                              Text('No hay items creados'),
                              SizedBox(height: 20),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: accentColor,
                                ),
                                child: Text('Crear item'),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewItem(category: _category),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: item is Item
                                ? ItemCard(
                                    item: item,
                                    color: _category.color,
                                    parentCategory: _category,
                                  )
                                : CategoryCard(
                                    category: item as Category,
                                    parentCategory: _category,
                                  ),
                          );
                        }, childCount: items.length),
                      );
                    }
                  },
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 150)),
              ],
            ),
          ),
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
      ),
    );
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _FilterHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: maxExtent == 0 ? 0 : 1,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: maxExtent == 0 ? const Offset(0, -1) : const Offset(0, 0),
          child: maxExtent == 0
              ? SizedBox.shrink()
              : SizedBox.expand(child: child),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_FilterHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
