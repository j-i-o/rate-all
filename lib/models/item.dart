import 'package:flutter_application_1/models/base_item.dart';

class Item extends BaseItem {
  final double rateValue;
  final String parentId;

  Item({
    required super.uid,
    required super.userId,
    super.category = 'item',
    required super.nombre,
    super.descripcion,
    required this.rateValue,
    required this.parentId,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'userId': userId,
    'category': category,
    'nombre': nombre,
    'descripcion': descripcion,
    'rateValue': rateValue,
    'parentId': parentId,
  };

  factory Item.fromMap(Map<String, dynamic> map) => Item(
    uid: map['uid'],
    userId: map['userId'],
    category: map['category'],
    nombre: map['nombre'],
    descripcion: map['descripcion'],
    rateValue: map['rateValue'],
    parentId: map['parentId'],
  );
}
