// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/providers/internships_provider.dart';
import 'package:pasantic_frontend/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  

  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final intershipsProvider = Provider.of<InternshipsProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
          )
        ],
      ),
      body: PasantiasCards(pasantias: intershipsProvider.internshipsResponses,
        onNextPagePasantias: ()=>{ intershipsProvider.getInternships()},),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap: (index) {
          currentIndex = index;
          if(currentIndex==2){
            Navigator.of(context).pushNamed('profile');
          }
          
        },
        items: [
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
