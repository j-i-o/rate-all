import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/authenticate/sign_in.dart';
import 'package:flutter_application_1/views/pages/authenticate/sign_up.dart';
import 'package:flutter_application_1/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  bool isSignUpForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            onChanged: () => setState(() {}),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                SizedBox(height: 50),
                if (isSignUpForm)
                  Column(
                    children: [
                      SignUp(),
                      SizedBox(height: 20),
                      Text('¿Ya tenés una cuenta?'),
                      TextButton(
                        onPressed: () {
                          setState(() => isSignUpForm = false);
                        },
                        child: Text('Iniciá sesión'),
                      ),
                    ],
                  ),
                if (!isSignUpForm)
                  Column(
                    children: [
                      SignIn(),
                      SizedBox(height: 20),
                      Text('¿No tenés cuenta?'),
                      TextButton(
                        onPressed: () {
                          setState(() => isSignUpForm = true);
                        },
                        child: Text('Crea tu cuenta'),
                      ),
                    ],
                  ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => onLoginPressed(context),
                  child: Text('Acceso rápido'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WidgetTree()),
    );
  }
}