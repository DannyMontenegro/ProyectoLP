// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 2;

  
  @override
  Widget build(BuildContext context) {
    final dynamic user = (ModalRoute.of(context)!.settings.arguments);
    final dynamic userData = user['payload']['user'];

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
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                  constraints: BoxConstraints(minHeight: 200),
                  alignment: Alignment.center,
                  child: Icon(Icons.person, size: 200),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.orange)),
              SizedBox(height: 50),
              Row(children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.4),
                    child: Text('Nombre: ', style: TextStyle(fontSize: 20))),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(userData['name'],
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis),
                )
              ]),
              SizedBox(height: 20),
              Row(children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.4),
                    child: Text('Linkedin: ', style: TextStyle(fontSize: 20))),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: ElevatedButton(
                    onPressed: () async {
                      await launch(userData['Student']['linkedinProfile']);
                    },
                    child: Text(userData['Student']['linkedinProfile'],
                        maxLines: 2,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis),
                  ),
                )
              ]),
              SizedBox(height: 20),
              Row(children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.4),
                    child: Text('Carrera: ', style: TextStyle(fontSize: 20))),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(userData['Student']['degree'],
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis),
                )
              ]),
              SizedBox(height: 20),
              Row(children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3),
                    child: Text('Resumen: ', style: TextStyle(fontSize: 20))),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                      userData['description'],
                      textAlign: TextAlign.justify,
                      maxLines: 7,
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis),
                )
              ]),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () {},
                  child: Text("Eliminar Cuenta",
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap: (index) async {
          currentIndex = index;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int? id = prefs.getInt('id');
          String data = await User.getUserById('$id');
          if (currentIndex == 0) {
            Navigator.of(context).pushNamed('home');
          }
          if(currentIndex == 1) {
            Navigator.of(context)
                .pushNamed('applications',arguments: json.decode(data));
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outlined),
              label: 'Pasantias',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_rounded),
              label: 'Postulaciones',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.orange,
          )
        ],
      ),
    );
  }
}

class LabelsProfile extends StatelessWidget {
  final String text;
  const LabelsProfile({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 50));
  }
}
