import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';

const List<Item> items = [
  Item(
    id: 0,
    tipo: 'categoria',
    nombre: 'Panaderías',
    descripcion: 'Los mejores restaurantes de la ciudad',
    icono: Icons.bakery_dining,
    color: Colors.amber,
    rateTipo: 'stars',
    rateIcon: Icons.star_rounded,
    reviews: [
      Item(
        id: 3,
        tipo: 'item',
        nombre: 'Zuri',
        descripcion: 'En 10 y 64',
        rateTipo: 'stars',
        rateIcon: Icons.star_rounded,
        rateValue: 4,
      ),
      Item(
        id: 4,
        tipo: 'item',
        nombre: 'La Capital',
        descripcion: 'En 9 y 65',
        rateTipo: 'stars',
        rateIcon: Icons.star_rounded,
        rateValue: 3,
      ),
    ],
  ),
  Item(
    id: 2,
    tipo: 'categoria',
    nombre: 'Películas',
    descripcion: 'Las mejores películas del año',
    icono: Icons.movie,
    rateTipo: 'thumbs',
    rateIcon: Icons.thumb_up,
    reviews: [
      Item(
        id: 5,
        tipo: 'item',
        nombre: 'Blade Runner 2049',
        descripcion: 'Película de ciencia ficción, secuela de Blade Runner',
        rateTipo: 'thumbs',
        rateIcon: Icons.thumb_up,
        rateValue: 1,
      ),
      Item(
        id: 9,
        tipo: 'item',
        nombre: 'Papá se volvió loco',
        descripcion: 'Prometía más, medio pelo',
        rateTipo: 'thumbs',
        rateIcon: Icons.thumb_up,
        rateValue: 0,
      )
    ],
  ),
  Item(
    id: 6,
    tipo: 'categoria',
    nombre: 'Cafés',
    descripcion: 'Las mejores cafeterías de la city',
    icono: Icons.coffee,
    color: Colors.red,
    rateTipo: 'number',
    rateIcon: null,
    reviews: [
      Item(
        id: 7,
        tipo: 'item',
        nombre: 'Mumi\'s',
        descripcion: 'Caro pero bueno, 50 e/10 y 11',
        rateTipo: 'number',
        rateIcon: null,
        rateValue: 8.5,
      ),
      Item(
        id: 8,
        tipo: 'item',
        nombre: 'Starbucks',
        descripcion: 'Caro, café solo malo, frapuccinos et al, en Baxar y 11 y 49',
        rateTipo: 'number',
        rateIcon: null,
        rateValue: 7,
      ),
    ],
  ),
];

class ListadoPage extends StatelessWidget {
  const ListadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .start,
          children: [for (var item in items) CategoryCard(item: item)],
        ),
      ),
    );
  }
}
