import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/domain/rating.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/category_provider.dart';
import 'package:flutter_application_1/providers/item_provider.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/icons.dart';

class NewCategory extends ConsumerStatefulWidget {
  const NewCategory({super.key, this.parentCategory, this.categoryToEdit});

  final Category? parentCategory;
  final Category? categoryToEdit;

  @override
  ConsumerState<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends ConsumerState<NewCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerDescripcion = TextEditingController();
  final TextEditingController _controllerRating = TextEditingController();
  final DatabaseService _db = DatabaseService();

  Color? accentColorSelected;
  String? ratingSelected;
  IconData? iconSelected;

  @override
  void initState() {
    super.initState();

    int? accentColorInt;
    if (widget.categoryToEdit != null) {
      accentColorInt = widget.categoryToEdit!.color.toARGB32();
    } else if (widget.parentCategory != null) {
      accentColorInt = widget.parentCategory!.color.toARGB32();
    }

    accentColorSelected = accentColorInt == null
        ? null
        : CategoryColors.colores.firstWhere(
            (c) => c.toARGB32() == accentColorInt,
          );

    iconSelected = widget.categoryToEdit?.icono;
    ratingSelected = widget.categoryToEdit?.rating.type.name;
    _controllerNombre.text = widget.categoryToEdit?.nombre ?? '';
    _controllerDescripcion.text = widget.categoryToEdit?.descripcion ?? '';
  }

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
              widget.categoryToEdit != null
                  ? 'Editar categoría'
                  : 'Nueva categoría',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                if (widget.categoryToEdit != null)
                  Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.parentCategory != null)
                        Text(
                          ' > ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      Icon(
                        widget.categoryToEdit!.icono,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        widget.categoryToEdit!.nombre,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
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
                        initialValue: accentColorSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Color'),
                        ),
                        items: CategoryColors.colores.map((Color c) {
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
                      child: DropdownButtonFormField<IconData>(
                        initialValue: iconSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Icono'),
                        ),
                        items: CategoryIcons.iconos.map((IconData i) {
                          return DropdownMenuItem<IconData>(
                            value: i,
                            alignment: AlignmentGeometry.center,
                            child: Icon(i),
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
                        //Este dato no se debe poder modificar si se edita, solo para crear
                        initialValue: ratingSelected,
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
                        onChanged: widget.categoryToEdit != null
                            ? null
                            : (value) {
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
                              icono: iconSelected ?? Icons.star_rounded,
                              color: accentColorSelected!,
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
                                itemsProvider(widget.parentCategory!),
                                asReload: true,
                              );
                            }
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        widget.categoryToEdit != null ? 'Actualizar' : 'Crear',
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
