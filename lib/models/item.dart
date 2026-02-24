import 'package:cloud_firestore/cloud_firestore.dart';
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
    super.createdAt,
    super.updatedAt,
    required this.rateValue,
    required this.parentId,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
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
    createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    updatedAt: (map['modifiedAt'] as Timestamp?)?.toDate(),
  );

  Item copyWith({
    String? uid,
    String? userId,
    String? nombre,
    String? descripcion,
    double? rateValue,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Item(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      rateValue: rateValue ?? this.rateValue,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
