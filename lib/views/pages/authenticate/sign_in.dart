import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? _errorFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Email requerido' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Contraseña requerida'
                  : null,
            ),
            SizedBox(height: 20),
            if (_errorFeedback != null)
              Text(_errorFeedback!, style: TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });
                  final email = _controllerEmail.text.trim();
                  final password = _controllerPassword.text.trim();
                  final user = await AuthService.signIn(email, password);
                  if (user == null) {
                    setState(() {
                      _errorFeedback = 'No se pudo iniciar sesión';
                    });
                  }
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
