import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    widget.controllerEmail.addListener(_onTextChanged);
    widget.controllerPassword.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controllerEmail.removeListener(_onTextChanged);
    widget.controllerPassword.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
              TextField(
                controller: widget.controllerEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresa tu email',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: widget.controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresa tu contraseña',
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.amber),
                onPressed:
                    widget.controllerEmail.text.isNotEmpty &&
                        widget.controllerPassword.text.isNotEmpty
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
    );
  }

  void onLoginPressed(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WidgetTree()),
    );
  }
}
