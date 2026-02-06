import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/widgets/item_card.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: item.color ?? Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(item.icono, size: 50, color: item.color != null ? Colors.white : null),
                SizedBox(width: 16),
                Text(
                  item.nombre,
                  style: TextStyle(
                    fontSize: 40,
                    color: item.color != null ? Colors.white : null,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                Text(
                  item.reviews?.length.toString() ?? '0',
                  style: TextStyle(
                    fontSize: 20,
                    color: item.color != null ? Colors.white : null,
                  ),
                ),
                Icon(
                  Icons.remove_red_eye_rounded,
                  color: item.color != null ? Colors.white : null,
                ),
                Spacer(),
                IconButton(
                  iconSize: 30,
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: item.color != null ? Colors.white : null,
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
            if(item.reviews != null)
              for (var item in item.reviews!)
                ItemCard(item: item)
          ],
        ),
      ),
    );
  }
}
