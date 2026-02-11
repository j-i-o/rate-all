import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/base_item.dart';

class Category extends BaseItem {
  final IconData icono;
  final Color color;
  final RatingConfig rating;
  final String? parentId;

  Category({
    required super.uid,
    required super.userId,
    required super.nombre,
    super.category = 'category',
    super.descripcion,
    required this.icono,
    required this.color,
    required this.rating,
    this.parentId,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'userId': userId,
    'category': category,
    'nombre': nombre,
    'descripcion': descripcion,
    'iconoCode': icono.codePoint,
    'iconoFont': icono.fontFamily,
    'iconoPackage': icono.fontPackage,
    'color': color.toARGB32(),
    'rating': rating.toMap(),
    'parentId': parentId,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    uid: map['uid'],
    userId: map['userId'],
    category: map['category'],
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
    );
  }
}
