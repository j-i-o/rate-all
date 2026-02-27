import 'package:flutter_application_1/models/item_sort.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemSortNotifier extends Notifier<ItemSort> {
  @override
  ItemSort build() => ItemSort.updatedDesc;

  void setSort(ItemSort sort) => state = sort;
}

final itemSortProvider = NotifierProvider<ItemSortNotifier, ItemSort>(
  ItemSortNotifier.new,
);
