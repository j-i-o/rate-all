import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/views/pages/new_item.dart';
import 'package:flutter_application_1/views/widgets/rating_widget.dart';
import 'package:flutter_application_1/views/widgets/swipeable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCard extends ConsumerStatefulWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.color,
    required this.parentCategory,
  });

  final Category parentCategory;
  final Item item;
  final Color color;

  @override
  ConsumerState<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends ConsumerState<ItemCard> {
  final DatabaseService _db = DatabaseService();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SwipeableCard(
      key: ValueKey(widget.item.uid),
      onEdit: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewItem(
            itemToEdit: widget.item,
            category: widget.parentCategory,
          ),
        ),
      ),
      onDelete: () async {
        //TODO: Actualizar db pero borrar localmente para ahorrar salidas
        await _db.deleteBaseItem(widget.item);
        ref.invalidate(itemsProvider(widget.parentCategory), asReload: true);
      },
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
                          rating: widget.parentCategory.rating,
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
                        maxLines: isExpanded ? 5 : null,
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
