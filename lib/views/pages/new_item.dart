import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/views/widgets/rating_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerDescripcion = TextEditingController();
  final DatabaseService _db = DatabaseService();
  late double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nuevo item', style: TextStyle(fontSize: 30)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(widget.category.icono, size: 30),
                Text(widget.category.nombre),
              ],
            ),
          ],
        ),
        backgroundColor: widget.category.color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20.0,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _controllerNombre,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: _controllerDescripcion,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Descripción'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text('Puntaje', style: TextStyle(fontSize: 20)),
                    ),
                    Flexible(
                      flex: 3,
                      child: RatingWidget(
                        rating: widget.category.rating,
                        value: ratingValue,
                        onChanged: (value) =>
                            setState(() => ratingValue = value),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: widget.category.color,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final user = ref.read(authProvider).value;
                            if (user == null) return;

                            final item = Item(
                              uid: '',
                              userId: user.uid,
                              rateValue: ratingValue,
                              nombre: _controllerNombre.text,
                              descripcion: _controllerDescripcion.text,
                              parentId: widget.category.uid,
                            );
                            _db.createItem(item);
                            Navigator.pop(context, true);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Guardar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
