import 'package:flutter/material.dart';

class Category {
  final String uid;
  final String userId;
  final String nombre;
  final String? descripcion;
  final IconData icono;
  final Color color;
  final String rateTipo;
  final IconData? rateIcon;
  final String? parentCategoryId;

  const Category({
    required this.uid,
    required this.userId,
    required this.nombre,
    this.descripcion,
    required this.icono,
    required this.color,
    required this.rateTipo,
    this.rateIcon,
    this.parentCategoryId,
  });
}
