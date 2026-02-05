import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            onChanged: () => setState(() {}),
            child: Column(
              children: [
                SizedBox(height: 100),
                Lottie.asset(
                  'assets/lotties/Stars.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                  repeat: false,
                ),
                FittedBox(
                  child: Text(
                    '¡¡Bienvenido a RateAll!!',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(height: 150),
                TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresa tu email',
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Email requerido' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresa tu contraseña',
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Contraseña requerida' : null,
                ),
                SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed:
                      _controllerEmail.text.isNotEmpty &&
                          _controllerPassword.text.isNotEmpty
                      ? () {
                          onLoginPressed(context);
                        }
                      : null,
                  child: Text('Iniciar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WidgetTree()),
    );
  }
}
