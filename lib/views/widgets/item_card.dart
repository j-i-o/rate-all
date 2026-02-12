import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/widgets/rating_widget.dart';
import 'package:flutter_application_1/views/widgets/swipeable_card.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.item, required this.color});

  final Item item;
  final Color color;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SwipeableCard(
      key: ValueKey(widget.item.uid),
      onEdit: () =>
          Navigator.pushNamed(context, '/new-item', arguments: widget.item),
      onDelete: () =>
          Navigator.pushNamed(context, '/new-item', arguments: widget.item),
      onTap: () => {
        setState(() {
          isExpanded = !isExpanded;
        }),
      },
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
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: CircleAvatar(
                            backgroundColor: widget.color,
                            radius: 12,
                          ),
                        ),
                        RatingWidget(
                          //Cambiar por el rating de la categoría! O sea que hay q pasarle a la ItemCard la categoria
                          rating: RatingConfig.stars,
                          value: widget.item.rateValue,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      widget.item.nombre,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: Text(
                        widget.item.descripcion ?? '',
                        style: TextStyle(fontSize: 16, letterSpacing: 0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: isExpanded ? 5 : null ,
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
