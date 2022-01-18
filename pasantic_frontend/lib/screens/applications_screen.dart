import 'package:flutter/material.dart';
import 'package:pasantic_frontend/widgets/oferta_postulacion.dart';
import 'package:pasantic_frontend/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pasantic_frontend/providers/user_provider.dart';
import 'dart:convert';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  int currentIndex = 1;
  dynamic pasantias;

  @override
  Widget build(BuildContext context) {
    final dynamic data = ModalRoute.of(context)!.settings.arguments;
    pasantias = data['payload']['student']['InternshipStudents'];

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: PostulacionesCards(pasantias: pasantias),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap: (index) async {
          currentIndex = index;
          if (currentIndex == 2) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int? id = prefs.getInt('id');
            String data = await User.getUserById('$id');
            Navigator.of(context)
                .pushNamed('profile', arguments: json.decode(data));
          }
          if (currentIndex == 0) {
            Navigator.of(context).pushNamed('home');
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
