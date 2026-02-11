import 'package:flutter_application_1/models/base_item.dart';

class Item extends BaseItem {
  final double rateValue;
  final String parentId;

  Item({
    required super.uid,
    required super.userId,
    super.type = 'item',
    required super.nombre,
    super.descripcion,
    required this.rateValue,
    required this.parentId,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'userId': userId,
    'type': type,
    'nombre': nombre,
    'descripcion': descripcion,
    'rateValue': rateValue,
    'parentId': parentId,
  };

  factory Item.fromMap(Map<String, dynamic> map) => Item(
    uid: map['uid'],
    userId: map['userId'],
    type: map['type'],
    nombre: map['nombre'],
    descripcion: map['descripcion'],
    rateValue: map['rateValue'],
    parentId: map['parentId'],
  );

  Item copyWith({
    String? uid,
    String? userId,
    String? nombre,
    String? descripcion,
    double? rateValue,
    String? parentId,
  }) {
    return Item(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      rateValue: rateValue ?? this.rateValue,
      parentId: parentId ?? this.parentId,
    );
  }
}
