import 'package:flutter/material.dart';

class Item {
  final int id;
  final String tipo;
  final String nombre;
  final String? descripcion;
  final IconData? icono;
  final Color? color;
  final String? rateTipo;
  //Si viene rateTipo y no viene Icon asumir un default star/thumbs up
  final IconData? rateIcon;
  final double? rateValue;
  final List<Item>? reviews;

  const Item({
    required this.id,
    required this.tipo,
    required this.nombre,
    this.descripcion,
    this.icono,
    this.color,
    this.rateTipo,
    this.rateIcon,
    this.rateValue,
    this.reviews,
  });
}
