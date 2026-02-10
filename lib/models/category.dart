import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';

class Category {
  final String uid;
  final String userId;
  final String nombre;
  final String? descripcion;
  final IconData icono;
  final Color color;
  final RatingConfig rating;
  final String? parentCategoryId;

  const Category({
    required this.uid,
    required this.userId,
    required this.nombre,
    this.descripcion,
    required this.icono,
    required this.color,
    required this.rating,
    this.parentCategoryId,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'userId': userId,
    'nombre': nombre,
    'descripcion': descripcion,
    'iconoCode': icono.codePoint,
    'iconoFont': icono.fontFamily,
    'iconoPackage': icono.fontPackage,
    'color': color.toARGB32(),
    'rating': rating.toMap(),
    'parentCategoryId': parentCategoryId,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    uid: map['uid'],
    userId: map['userId'],
    nombre: map['nombre'],
    descripcion: map['descripcion'],
    icono: IconData(
      map['iconoCode'],
      fontFamily: map['iconoFont'],
      fontPackage: map['iconoPackage'],
    ),
    color: Color(map['color']),
    rating: RatingConfig.fromMap(map['rating']),
    parentCategoryId: map['parentCategoryId'],
  );

  Category copyWith({
    String? uid,
    String? userId,
    String? nombre,
    String? descripcion,
    IconData? icono,
    Color? color,
    RatingConfig? rating,
    String? parentCategoryId,
  }) {
    return Category(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      rating: rating ?? this.rating,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
    );
  }
}
