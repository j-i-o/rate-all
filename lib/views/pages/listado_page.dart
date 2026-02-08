import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';
import 'package:flutter_application_1/debug/mock_items.dart';

class ListadoPage extends StatelessWidget {
  const ListadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 8,
          mainAxisAlignment: .start,
          children: [
            for (var item in items) CategoryCard(item: item),
            SizedBox(height: 120),
            ],
        ),
      ),
    );
  }
}
