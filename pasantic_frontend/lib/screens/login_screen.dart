import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic idUser;
  dynamic rol;

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: LoaderOverlay(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email registrado en la aplicación',
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    return (value != null && !value.contains('@'))
                        ? 'El correo debe utilizar @'
                        : null;
                  },
                  onChanged: (String value) {
                    email = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Contraseña de la cuenta registrada',
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('register');
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(
                          color: Colors.orange,
                          decoration: TextDecoration.underline,
                          fontSize: 17),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      context.loaderOverlay.show();

                      await _getDataFromLogin(email, password);
                      context.loaderOverlay.hide();
                      if (idUser != null && rol != null) {
                        (rol=="estudiante")? Navigator.pushNamed(context, 'home') : Navigator.pushNamed(context, 'internships');
                        
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Credenciales Incorrectas')));
                      }
                    },
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange))),
              ]),
        ),
      ),
    );
  }

  _getDataFromLogin(String email, String password) async {
    const String baseUrl = '10.0.2.2:3001';
    const String segment = '/login';
    var url = Uri.http(baseUrl, segment);

    final body = {'email': '$email', 'password': '$password'};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    if (jsonDecoded.length != 1) {
      idUser = jsonDecoded['payload']['user']['id'];
      rol = jsonDecoded['payload']['user']['role'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', idUser);
      await prefs.setString('rol', rol);
    }
  }
}
