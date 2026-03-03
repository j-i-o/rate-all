import 'package:flutter_application_1/models/base_item.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/models/item_sort.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/providers/item_sort_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sortedItemsProvider =
    Provider.family<AsyncValue<List<BaseItem>>, Category>((ref, category) {
      final itemsAsync = ref.watch(itemsProvider(category));
      final sort = ref.watch(itemSortProvider);

      return itemsAsync.whenData((itemList) {
        final List<Item> items = [];
        final List<Category> categories = [];
        for (final item in itemList) {
          if (item is Category) categories.add(item);
          if (item is Item) items.add(item);
        }

        switch (sort) {
          case ItemSort.nameAsc:
            items.sort((a, b) => a.nombre.compareTo(b.nombre));
            categories.sort((a, b) => a.nombre.compareTo(b.nombre));
            break;
          case ItemSort.nameDesc:
            items.sort((a, b) => b.nombre.compareTo(a.nombre));
            categories.sort((a, b) => b.nombre.compareTo(a.nombre));
            break;
          case ItemSort.ratingAsc:
            items.sort((a, b) {
              return a.rateValue.compareTo(b.rateValue);
            });
            break;
          case ItemSort.ratingDesc:
            items.sort((a, b) {
              return b.rateValue.compareTo(a.rateValue);
            });
            break;
          case ItemSort.updatedAsc:
            items.sort((a, b) {
              final aDate = a.updatedAt ?? DateTime.now();
              final bDate = b.updatedAt ?? DateTime.now();
              return aDate.compareTo(bDate);
            });
            categories.sort((a, b) {
              final aDate = a.updatedAt ?? DateTime.now();
              final bDate = b.updatedAt ?? DateTime.now();
              return aDate.compareTo(bDate);
            });
            break;
          case ItemSort.updatedDesc:
            items.sort((a, b) {
              final aDate = a.updatedAt ?? DateTime.now();
              final bDate = b.updatedAt ?? DateTime.now();
              return bDate.compareTo(aDate);
            });
            categories.sort((a, b) {
              final aDate = a.updatedAt ?? DateTime.now();
              final bDate = b.updatedAt ?? DateTime.now();
              return bDate.compareTo(aDate);
            });
            break;
        }

        final itemsSorted = [...categories, ...items];
        return itemsSorted;
      });
    });
