// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pasantic_frontend/helpers/changeProcessString.dart';
import 'package:pasantic_frontend/helpers/getDiffTime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pasantic_frontend/widgets/student_interships.dart';
import 'package:pasantic_frontend/providers/user_provider.dart'
    as user_provider;

class InternshipDetailEnterpriseScreen extends StatefulWidget {
  const InternshipDetailEnterpriseScreen({Key? key}) : super(key: key);

  @override
  State<InternshipDetailEnterpriseScreen> createState() =>
      _InternshipDetailEnterpriseScreen();
}

class _InternshipDetailEnterpriseScreen
    extends State<InternshipDetailEnterpriseScreen> {
  dynamic enterprise;
  dynamic idStudent;

  @override
  void initState() {
    _getIdUSer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getIdUSer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    //var url = Uri.http('10.0.2.2:3001', '/users/$id');
    var url = Uri.http('192.168.56.1:3001', '/users/$id');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    idStudent = jsonData['payload']['user']['Student']['id'];
    print("Obteniendo el id: $idStudent");
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Internship pasantia =
        ModalRoute.of(context)!.settings.arguments as Internship;
    _getEnterprise(pasantia.idEnterprise);

    return Scaffold(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(pasantia.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.business, size: 40),
                  SizedBox(width: 15),
                  Text(
                      enterprise != null
                          ? enterprise['User']['name']
                          : 'Empresa',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 30),
              Row(children: [
                Icon(Icons.monetization_on, size: 40),
                SizedBox(width: 15),
                Text('\$${pasantia.payment.toString()}/mes',
                    style: TextStyle(fontSize: 20)),
              ]),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.location_on, size: 40),
                  SizedBox(width: 15),
                  Text(pasantia.location),
                  SizedBox(width: 80),
                  Icon(Icons.access_time, size: 40),
                  SizedBox(width: 15),
                  Text(
                      '${getDiffYMD(pasantia.dateFrom, pasantia.dateTo)} meses',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 30),
              Text("Descripcion:",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              Text(pasantia.description,
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text("Proceso:",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              Text(changeProcessString(pasantia.internshipProcess),
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 25)),
              TextButton(
                  onPressed: () async {
                    List lista = [];
                    var id = pasantia.id;
                    var url = Uri.http(
                        '192.168.56.1:3001', '/internships/interns/$id');

                    var jsonData = await http.get(url);
                    var jsonDecoded = json.decode(jsonData.body);

                    for (int i = 0;
                        i < jsonDecoded['payload']['interns'].length;
                        i++) {
                      lista.add(jsonDecoded['payload']['interns'][i]);
                    }

                    for (int i = 0; i < lista.length; i++) {
                      id = lista[i]["idStudent"];
                      url = Uri.http('192.168.56.1:3001', '/students/$id');
                      jsonData = await http.get(url);
                      jsonDecoded = json.decode(jsonData.body);
                      lista[i]['estudiante'] =
                          jsonDecoded["payload"]["student"]["User"];
                    }

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SecondRoute(lista: lista);
                      },
                    ));
                  },
                  child: Text("PASANTES",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange)))
            ],
          ),
        ),
      ),
    );
  }

  _getEnterprise(int id) async {
    const String baseUrl = '192.168.56.1:3001';
    String segment = '/enterprises/$id';
    var url = Uri.http(baseUrl, segment);
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    if (this.mounted) {
      setState(() => enterprise = jsonData['payload']['enterprise']);
    }
  }
}

class SecondRoute extends StatelessWidget {
  //static const routeName = '/SecondRoute';
  final lista;

  const SecondRoute({
    Key? key,
    required this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: StudentIntershipWidget(students: lista),
    );
  }
}
