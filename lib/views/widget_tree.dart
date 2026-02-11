import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/drawer_widget.dart';
import 'package:flutter_application_1/views/widgets/floating_button_widget.dart';
import 'pages/listado_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: DrawerWidget(),
      body: ListadoPage(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
