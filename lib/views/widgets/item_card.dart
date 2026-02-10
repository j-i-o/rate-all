import 'package:flutter/material.dart';
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
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(item.nombre, style: TextStyle(fontSize: 24)),
                subtitle: Text(
                  item.descripcion ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: RatingWidget(
                  rateTipo: 'stars',
                  rateValue: item.rateValue,
                  rateIcon: Icons.stars_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
