import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';

abstract class BaseItem {
  final String uid;
  final String userId;
  final String type;
  final String nombre;
  final String? descripcion;

  BaseItem({ required this.uid, required this.userId, required this.nombre, required this.type, this.descripcion });

}

BaseItem baseItemFromMap(Map<String, dynamic> map) {
  switch (map['type']) {
    case 'category':
      return Category.fromMap(map);
    case 'item':
      return Item.fromMap(map);
    default:
      throw Exception('Invalid type: ${map['type']}');
  }
}