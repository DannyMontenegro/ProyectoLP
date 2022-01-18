import 'package:flutter/material.dart';

class NewInternshipScreen extends StatefulWidget {
   
  const NewInternshipScreen({Key? key}) : super(key: key);

  @override
  State<NewInternshipScreen> createState() => _NewInternshipScreenState();
}

class _NewInternshipScreenState extends State<NewInternshipScreen> {
  String workmode = "Presencial";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            children:  [
              const Text("Crear Pasantía",
                    style: TextStyle(color: Colors.orange,
                                    fontSize: 25)
              ),
              TextFormField(
                    decoration: const InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: 'Nombre de la pasantía',
                            labelText: 'Nombre',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(
                            icon: Icon(Icons.location_on),
                            hintText: 'Lugar de la pasantía',
                            labelText: 'Localización',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Salario por mes',
                            labelText: 'Salario',
                          ),
                  onChanged: (String value){
                  },
                ),
                Row(
                children: [
                  const Icon(
                    Icons.home_work
                  ),
                  const SizedBox(width: 20),
                  const Text("Modo de trabajo"),
                  const SizedBox(width: 20),
                  DropdownButton(
                    value : workmode,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    onChanged: (String? newValue){
                      setState(() {
                        workmode = newValue!;
                        
                        
                      });
                    },
                    items: <String>['Presencial', 'Distancia']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                  ),
                ],
              ),
              TextFormField(
                    decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Campo de trabajo',
                            labelText: 'Campo',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Descripción de la pasantía',
                            labelText: 'Descripción',
                            border: OutlineInputBorder(
                              
                            )
                            //Colocar el label en la parte de arriba
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                  onChanged: (String value){
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Proceso de aplicación',
                            labelText: 'Proceso',
                            border: OutlineInputBorder(
                              
                            )
                            //Colocar el label en la parte de arriba
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                  onChanged: (String value){
                  },
                ),
            ]
          )
        )
      )
    );
  }
}