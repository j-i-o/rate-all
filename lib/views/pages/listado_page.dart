import 'package:flutter/material.dart';

class ListadoPage extends StatelessWidget {
  const ListadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .start,
          children: [
            Card.outlined(
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.bakery_dining, size: 50),
                      title: Text('Panaderías', style: TextStyle(fontSize: 24)),
                      trailing: Icon(Icons.chevron_right, size: 40),
                    ),
                  ),
                ],
              ),
            ),
            Card.outlined(
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.movie, size: 50),
                      title: Text('Películas', style: TextStyle(fontSize: 24)),
                      trailing: Icon(Icons.chevron_right, size: 40),
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
