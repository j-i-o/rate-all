import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Contraseña requerida';
                }
                if (value.length < 8) {
                  return 'La contraseña debe tener al menos 8 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            if (_errorFeedback != null)
              Text(_errorFeedback!, style: TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implementar la lógica de inicio de sesión
                  setState(() => _errorFeedback = null);
                  final email = _controllerEmail.text.trim();
                  final password = _controllerPassword.text.trim();
                  final user = await AuthService.signUp(email, password);

                  if (user == null) {
                    setState(() => _errorFeedback = 'Error al crear la cuenta');
                  }
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
