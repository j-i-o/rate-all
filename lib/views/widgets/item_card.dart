import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/widgets/rating_widget.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      onHorizontalDragStart: (details) => print(details),
      child: Card.outlined(
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:10.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RatingWidget(
                          //Cambiar por el rating de la categoría! O sea que hay q pasarle a la ItemCard la categoria
                          rating: RatingConfig.stars,
                          value: item.rateValue,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(item.nombre, style: TextStyle(fontSize: 20)),
                    subtitle: Text(
                      item.descripcion ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
