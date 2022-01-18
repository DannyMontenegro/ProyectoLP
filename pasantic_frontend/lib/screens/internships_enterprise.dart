import 'package:flutter/material.dart';


class IntershipsScreen extends StatefulWidget{

  const IntershipsScreen({Key? key}) : super(key: key);

  @override
  State<IntershipsScreen> createState() => _IntershipsScreenState();
}

class _IntershipsScreenState extends State<IntershipsScreen>{
  int currentIndex = 0;


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
      body: const Center(
        child: Text("Pasantías creadas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('newInternship');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex : currentIndex,
        showUnselectedLabels: false,
        onTap: (index){
          currentIndex = index;
          // Pantalla de perfil de empresa
        },
        items: const [
          BottomNavigationBarItem(
            icon:  Icon(Icons.work_outlined),
            label: 'Pasantías',
            backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.orange
          ),
        ],
        )
    );
    
  }
}