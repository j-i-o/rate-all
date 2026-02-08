import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/pages/item_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage(item: item))),
      onHorizontalDragStart: (details) => print(details),
      child: Card.outlined(
        color: item.color ?? Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(item.icono, size: 50, color: item.color != null ? Colors.white : null),
                title: Text(item.nombre, style: TextStyle(fontSize: 24, color: item.color != null ? Colors.white : null, overflow: TextOverflow.ellipsis)),
                trailing: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.reviews?.length.toString() ?? '0', style: TextStyle(fontSize: 18, color: item.color != null ? Colors.white : null)),
                    Icon(Icons.remove_red_eye_rounded, color: item.color != null ? Colors.white : null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
