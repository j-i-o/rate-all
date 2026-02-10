import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
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

class _NewItemState extends State<NewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerDescripcion = TextEditingController();
  Color accentColorSelected = Colors.amber;
  Icon iconSelected = Icon(Icons.star_rounded);
  late String rateTipoSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
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
                        onChanged: (value) {},
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
                            setState(() => rateTipoSelected = value);
                          }
                        },
                      ),
                    ),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: accentColorSelected,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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
