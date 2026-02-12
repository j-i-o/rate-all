import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewCategory extends ConsumerStatefulWidget {
  const NewCategory({super.key, this.parentCategory});

  final Category? parentCategory;

  @override
  ConsumerState<NewCategory> createState() => _NewCategoryState();
}

const List<Color> colores = [
  Colors.amber,
  Colors.green,
  Colors.teal,
  Colors.blue,
  Colors.deepPurple,
  Colors.red,
  Colors.brown,
];
const List<Icon> iconos = [
  Icon(Icons.star_rounded),
  Icon(Icons.ac_unit_rounded),
  Icon(Icons.airplanemode_active_rounded),
  Icon(Icons.coffee_rounded),
  Icon(Icons.movie_rounded),
];

class _NewCategoryState extends ConsumerState<NewCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerDescripcion = TextEditingController();
  final DatabaseService _db = DatabaseService();

  late Color accentColorSelected =
      widget.parentCategory?.color ?? ref.read(accentColorProvider);
  Icon iconSelected = Icon(Icons.star_rounded);
  late String ratingSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 25,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nueva categoría',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            if (widget.parentCategory != null)
              Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.parentCategory!.icono,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    widget.parentCategory!.nombre,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
          ],
        ),
        backgroundColor: accentColorSelected,
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
                Row(
                  spacing: 15,
                  children: [
                    Flexible(
                      flex: 4,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _controllerNombre,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<Color>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Color'),
                        ),
                        items: colores.map((Color c) {
                          return DropdownMenuItem<Color>(
                            value: c,
                            child: Center(
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: c,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (Color? color) => {
                          if (color != null)
                            {
                              setState(() {
                                accentColorSelected = color;
                              }),
                            },
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<Icon>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Icono'),
                        ),
                        items: iconos.map((Icon i) {
                          return DropdownMenuItem<Icon>(
                            value: i,
                            alignment: AlignmentGeometry.center,
                            child: i,
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => iconSelected = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Tipo de evaluación'),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'stars',
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.star_rounded, color: Colors.amber),
                                Text('Estrellas'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'thumbs',
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.thumbs_up_down_rounded),
                                Text('Pulgares'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'number',
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.numbers_rounded),
                                Text('Números'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => ratingSelected = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _controllerDescripcion,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Descripción'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: accentColorSelected,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final user = ref.read(authProvider).value;
                            if (user == null) return;

                            final category = Category(
                              uid: '',
                              userId: user.uid,
                              nombre: _controllerNombre.text,
                              descripcion: _controllerDescripcion.text,
                              icono: iconSelected.icon!,
                              color: accentColorSelected,
                              rating: ratingSelected == 'stars'
                                  ? RatingConfig.stars
                                  : ratingSelected == 'thumbs'
                                  ? RatingConfig.thumbs
                                  : RatingConfig.numeric,
                              parentId: widget.parentCategory?.uid,
                            );
                            _db.createCategory(category);
                            ref.invalidate(categoriesProvider, asReload: true);
                            if (widget.parentCategory != null) {
                              ref.invalidate(
                                itemsProvider(widget.parentCategory!), asReload: true,
                              );
                            }
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Crear',
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
