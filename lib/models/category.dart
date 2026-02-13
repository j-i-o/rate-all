import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/base_item.dart';

class Category extends BaseItem {
  final IconData icono;
  final Color color;
  final RatingConfig rating;
  final String? parentId;
  final int? children;

  Category({
    required super.uid,
    required super.userId,
    required super.nombre,
    super.type = 'category',
    super.descripcion,
    required this.icono,
    required this.color,
    required this.rating,
    this.parentId,
    this.children,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    'iconoCode': icono.codePoint,
    'iconoFont': icono.fontFamily,
    'iconoPackage': icono.fontPackage,
    'color': color.toARGB32(),
    'rating': rating.toMap(),
    'parentId': parentId,
    'children': children,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    uid: map['uid'],
    userId: map['userId'],
    type: map['type'],
    nombre: map['nombre'],
    descripcion: map['descripcion'],
    icono: IconData(
      map['iconoCode'],
      fontFamily: map['iconoFont'],
      fontPackage: map['iconoPackage'],
    ),
    color: Color(map['color']),
    rating: RatingConfig.fromMap(map['rating']),
    parentId: map['parentId'],
    children: map['children'],
  );

  Category copyWith({
    String? uid,
    String? userId,
    String? nombre,
    String? descripcion,
    IconData? icono,
    Color? color,
    RatingConfig? rating,
    String? parentId,
    int? children,
  }) {
    return Category(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      rating: rating ?? this.rating,
      parentId: parentId ?? this.parentId,
      children: children ?? this.children,
    );
  }
}
