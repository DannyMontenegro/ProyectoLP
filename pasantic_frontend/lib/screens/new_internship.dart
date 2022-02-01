import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:pasantic_frontend/providers/enterpriseInternship_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class NewInternshipScreen extends StatefulWidget {
   
  const NewInternshipScreen({Key? key}) : super(key: key);

  @override
  State<NewInternshipScreen> createState() => _NewInternshipScreenState();
}

class _NewInternshipScreenState extends State<NewInternshipScreen> {
  String workmode = "Presencial";
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final nombre = TextEditingController();
  final localizacion = TextEditingController();
  final salario = TextEditingController();
  final descripcion = TextEditingController();
  final proceso = TextEditingController();
  final campo = TextEditingController();

  var formatter = DateFormat("yyyy-MM-dd");

 


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
                    controller: nombre,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: 'Nombre de la pasantía',
                            labelText: 'Nombre',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    controller: localizacion,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.location_on),
                            hintText: 'Lugar de la pasantía',
                            labelText: 'Localización',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    controller: salario,
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
                    items: <String>['Presencial', 'Remoto']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                  ),
                  const SizedBox(width: 20),
                  const Text("Fecha inicio"),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 220,
                    child: TextFormField(
                      controller: startDate,
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        _selectStartDate();

                      },
                      validator: (value){
                        if(endDate.text==""){
                          return null;
                        }
                        DateTime inicio = DateTime.parse(value!);
                        
                        DateTime fin = DateTime.parse(endDate.text);
                        
                        return (fin.isBefore(inicio)) ? "Fecha inicio debe ser anterior a fin" : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                  ),
                  const SizedBox(width: 20),
                  const Text("Fecha Fin"),
                  const SizedBox(width: 35),
                  SizedBox(
                    width: 220,
                    child: TextFormField(
                      controller: endDate,
                      validator: (value){
                        if(startDate.text==''){
                          return null;
                        }
                        DateTime inicio = DateTime.parse(startDate.text);
                        
                        DateTime fin = DateTime.parse(value!);
                        
                        return (inicio.isAfter(fin)) ? "Fecha fin debe ser posterior a inicio" : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        _selectEndDate();

                      },
                      
                    ),
                  )
                ],
              ),
              
              TextFormField(
                    controller: campo,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.school_outlined),
                            hintText: 'Campo de trabajo',
                            labelText: 'Campo',
                          ),
                  onChanged: (String value){
                  },
                ),
                TextFormField(
                    maxLines: 10,
                    controller: descripcion,
                    decoration: const InputDecoration(
                            icon: Icon(Icons.description_outlined),
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
                    controller: proceso, 
                    decoration: const InputDecoration(
                            icon: Icon(Icons.dehaze_outlined),
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
                TextButton(
                  onPressed: () async { 
                    context.loaderOverlay.show();
                    await saveInternship();
                    await Provider.of<EnterpriseInternshipProvider>(context, listen: false).getInternships();
                    context.loaderOverlay.hide();
                    Navigator.of(context).pushNamed('internships');
                  },
                  child: const Text("Crear Pasantía",
                                    style: TextStyle(color: Colors.white,
                                                    fontSize: 20)),
                  style :ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.orange)
                  )
                ),
            ]
          )
        )
      )
    );
  }

  Future _selectStartDate() async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:  DateTime(2022),
      lastDate:  DateTime(2024)
    );

    

    if(picked!=null) setState(()=>startDate.text = formatter.format(picked));
  }

  Future _selectEndDate() async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:  DateTime(2022),
      lastDate:  DateTime(2024)
    );
    //print(formatter.format(picked!));
    if(picked!=null) setState(()=>endDate.text = formatter.format(picked));
  }

  saveInternship() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const String baseUrl = '10.0.2.2:3001';
    const String segment = '/internships';

    var url = Uri.http(baseUrl, segment);
    final body = {
      'title': nombre.text,
      'description' : descripcion.text,
      'industry': campo.text,
      'internshipProcess': proceso.text,
      'dateFrom': startDate.text,
      'dateTo': endDate.text,
      'location': localizacion.text,
      'workMode': workmode,
      'idEnterprise': prefs.getInt('id2'),
      'payment': salario.text
    };
    final jsonString = json.encode(body);
    await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonString);
    //setState((){});


  }
}