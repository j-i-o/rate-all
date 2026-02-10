class Item {
  final String uid;
  final String userId;
  final String nombre;
  final String? descripcion;
  final double rateValue;
  final String categoryId;

  const Item({
    required this.uid,
    required this.userId,
    required this.nombre,
    this.descripcion,
    required this.rateValue,
    required this.categoryId,
  });
}
