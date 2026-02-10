import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/app_user.dart';
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

  Future getMainCategories(AppUser user) async {
    final snapshot = await itemCollection
        .where('userId', isEqualTo: user.uid)
        .where('parentCategoryId', isNull: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => Category.fromMap(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  Future createCategory(Category category) async {
    final docRef = itemCollection.doc();

    final categoryWithId = category.copyWith(uid: docRef.id);

    await docRef.set(categoryWithId.toMap());
  }

  //getList of items sin parentId

  //getList of items de una categoria
}
