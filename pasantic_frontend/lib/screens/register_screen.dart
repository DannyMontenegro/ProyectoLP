import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';

class RegisterScreen extends StatefulWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String value = "Estudiante";
  IconData icon = Icons.person_outline;
  final nombre = TextEditingController();
  final contrasenia = TextEditingController();
  final email = TextEditingController();
  final descripcion = TextEditingController();
  final profile = TextEditingController();
  final degree = TextEditingController();
  final phone = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
               "Formulario de registro",
               style: TextStyle(color: Colors.orange,
                                fontSize: 25),
             ),
              TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email de registro',
                    labelText: 'Email',
                  ),
                  onChanged: (String value){
                  },
                  validator: (value) {
                    return (value != null && !value.contains('@')) ? 'El correo debe utilizar @' : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                    controller: contrasenia,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Contraseña de registro',
                    labelText: 'Contraseña',
                  ),
                  onChanged: (String value){
                  },
                  obscureText:  true,
                ),
                TextFormField(
                    controller: nombre,
                    decoration:  InputDecoration(
                    icon: Icon(icon),
                    hintText: 'Nombre de registro',
                    labelText: 'Nombre',
                  ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    controller: descripcion,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.description_outlined),
                    hintText: 'Cuéntanos sobre tí',
                    labelText: 'Descripción',
                  ),
                  onChanged: (String value){
                  },
                ),
              Row(
                children: [
                  const Icon(
                    Icons.dehaze_outlined,
                  ),
                  const SizedBox(width: 20),
                  const Text("Rol"),
                  const SizedBox(width: 20),
                  DropdownButton(
                    value : value,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    onChanged: (String? newValue){
                      setState(() {
                        value = newValue!;
                        icon = ((newValue)=="Estudiante")? Icons.person_outline : Icons.business_sharp;
                        
                      });
                    },
                    items: <String>['Estudiante', 'Empresa']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                  ),
                ],
              ),
              if(value=="Empresa")
              TextFormField(
                    controller: phone,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.local_phone_outlined),
                    hintText: 'Número telefónico',
                    labelText: 'Telefono',
                  ),
                  onChanged: (String value){
                  },
                ),
              if(value=="Estudiante")
              Column(
                children: [
                  TextFormField(
                    controller: degree,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.school_outlined),
                    hintText: 'Carrera',
                    labelText: 'Carrera',
                  ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    controller: profile,
                    decoration: const InputDecoration(
                    icon: Icon(Icons.insert_link),
                    hintText: 'Perfil de Linkedin',
                    labelText: 'Enlace a perfil de Linkedin',
                  ),
                  onChanged: (String value){
                  },
                ),
                
                ]
              ),
              TextButton(
                  onPressed: ()async { 
                    context.loaderOverlay.show();
                    await registerUser();
                    context.loaderOverlay.hide();
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Text("Crear Cuenta",
                                    style: TextStyle(color: Colors.white,
                                                    fontSize: 20)),
                  style :ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.orange)
                  )
                ),
            ]
          ),
        ),
      ),
    );

  }

  registerUser() async {
    const String baseUrl = '10.0.2.2:3001';
    String segment = '/users';

    var url = Uri.http(baseUrl, segment);
    var body = {
      'email': email.text,
      'password':contrasenia.text,
      'name': nombre.text,
      'description': descripcion.text,
      'role': value.toLowerCase()
    };

    var jsonString = json.encode(body);
    final res = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonString);

    final user = json.decode(res.body);
    print(user);
    var id = user["payload"]["user"]["id"];

    if(value=="Estudiante"){
      segment = "/students";
      body = {
        'idUser': id.toString(),
        'linkedinProfile': profile.text,
        'degree': degree.text
      };
    }else{
      segment = "/enterprises";
      body = {
        'idUser': id.toString(),
        'phone_numer': phone.text
      };
    }
    url = Uri.http(baseUrl, segment);
    jsonString = json.encode(body);
    await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonString);
    setState((){});



  }
}
