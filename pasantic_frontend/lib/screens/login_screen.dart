import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({Key? key}) : super(key: key);
  
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             const Text(
               "SIGN IN",
               style: TextStyle(color: Colors.orange,
                                fontSize: 25),
             ),
             TextFormField(
                decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email registrado en la aplicación',
                labelText: 'Email',
              ),
              validator: (value) {
                return (value != null && !value.contains('@')) ? 'El correo debe utilizar @' : null;
              },

              onChanged: (String value){
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
              obscureText:  true,
              onChanged: (String value){
                password = value;
              },
            ),
            
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
               "Crear cuenta",
               style: TextStyle(color: Colors.orange,
                                decoration: TextDecoration.underline,
                                fontSize: 17),
             ),

            ),
             
             TextButton(
              onPressed: (){
                
              },
              child: const Text("Login",
                                style: TextStyle(color: Colors.white,
                                                fontSize: 20)),
              style :ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.orange)
               )

            ),
           ]
        ),
      ),
    );
  }
}
