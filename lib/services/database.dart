import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/app_user.dart';
import 'package:flutter_application_1/models/base_item.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/models/category.dart';

class DatabaseService {
  // collection reference
  final CollectionReference itemCollection = FirebaseFirestore.instance
      .collection('items');

  Future updateItemData(Item item) async {
    // return await itemCollection.doc(item.uid).update(item.toMap());
  }

  Future saveItemData(Item item) async {
    // return await itemCollection.doc().set(item.toMap());
  }

  Future<List<Category>> getMainCategories(AppUser user) async {
    final snapshot = await itemCollection
        .where('userId', isEqualTo: user.uid)
        .where('parentId', isNull: true)
        .get();

    List<Category> categories = [];

    for (final doc in snapshot.docs) {
      final childrenCount = await itemCollection
          .where('parentId', isEqualTo: doc.id)
          .count()
          .get();
      final data = Map<String, dynamic>.from(
        doc.data() as Map<String, dynamic>,
      );
      data['children'] = childrenCount.count;
      categories.add(Category.fromMap(data));
    }

    return categories;
  }

  Future createCategory(Category category) async {
    final docRef = itemCollection.doc();

    final categoryWithId = category.copyWith(uid: docRef.id);

    await docRef.set(categoryWithId.toMap());
  }

  Future createItem(Item item) async {
    final docRef = itemCollection.doc();

    final itemWithId = item.copyWith(uid: docRef.id);

    await docRef.set(itemWithId.toMap());
  }

  Future<List<BaseItem>> getItems(Category category, AppUser user) async {
    final snapshot = await itemCollection
        .where('parentId', isEqualTo: category.uid)
        .get();
    List<BaseItem> items = snapshot.docs
        .map((doc) => baseItemFromMap(doc.data() as Map<String, dynamic>))
        .toList();

    for (final item in items) {
      if (item is Category) {
        final childrenCount = await itemCollection
            .where('parentId', isEqualTo: item.uid)
            .count()
            .get();
        Category updatedCategory = item.copyWith(children: childrenCount.count);
        items[items.indexOf(item)] = updatedCategory;
      }
    }

    return items;
  }

  Future deleteBaseItem(BaseItem item) async {
    //Get all items this category is parent to
    //Iterate through every item and delete
    //Finally delete the category
    if (item is Category) {
      final children = await itemCollection
          .where('parentId', isEqualTo: item.uid)
          .get();

      for (final child in children.docs) {
        await itemCollection.doc(child.id).delete();
      }
    }

    return await itemCollection.doc(item.uid).delete();
  }

  //No usado
  Future updateCategoryCount(Category category) async {
    final childrenCount = await itemCollection
        .where('parentId', isEqualTo: category.uid)
        .count()
        .get();
    Category updatedCategory = category.copyWith(children: childrenCount.count);
    return updatedCategory;
  }

  //getList of items sin parentId

  //getList of items de una categoria
}
