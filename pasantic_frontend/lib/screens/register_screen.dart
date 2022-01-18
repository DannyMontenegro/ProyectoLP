import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String value = "Estudiante";
  IconData icon = Icons.person_outline;

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
          icon: Icon(Icons.arrow_back, color: Colors.orange),
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
                    decoration:  InputDecoration(
                    icon: Icon(icon),
                    hintText: 'Nombre de registro',
                    labelText: 'Nombre',
                  ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
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
                    decoration: const InputDecoration(
                    icon: Icon(Icons.school_outlined),
                    hintText: 'Carrera',
                    labelText: 'Carrera',
                  ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
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
                  onPressed: (){ 
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
}
