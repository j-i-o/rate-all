import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/views/pages/item_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage(category: category))),
      onHorizontalDragStart: (details) => print(details),
      child: Card.outlined(
        color: category.color,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(category.icono, size: 50, color: Colors.white),
                title: Text(category.nombre, style: TextStyle(fontSize: 24, color: Colors.white, overflow: TextOverflow.ellipsis)),
                trailing: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(category.children.toString(), style: TextStyle(fontSize: 18, color: Colors.white)),
                    Icon(Icons.remove_red_eye_rounded, color: Colors.white),
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
