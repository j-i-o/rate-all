import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/views/widgets/floating_button_widget.dart';
import 'package:flutter_application_1/views/widgets/item_card.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.category});

  final Category category;

  //Al ingresar a esta pagina hay q traer todos los items de la categoría en donde nos metimos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: category.color,
        title: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  category.icono,
                  size: 50,
                  color: category.color,
                ),
                SizedBox(width: 16),
                Text(
                  category.nombre,
                  style: TextStyle(
                    fontSize: 40,
                    color: category.color,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'X',
                      style: TextStyle(
                        fontSize: 20,
                        color: category.color,
                      ),
                    ),
                    Icon(
                      Icons.remove_red_eye_rounded,
                      color: category.color,
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  iconSize: 30,
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: category.color,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 5,
          children: [
            // if(item.reviews != null)
            //   for (var item in item.reviews!)
            //     ItemCard(item: item)
          ],
        ),
      ),
      floatingActionButton: FloatingButtonWidget(newItem: true),
    );
  }
}
