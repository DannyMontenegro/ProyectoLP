import 'package:flutter/material.dart';
import 'package:pasantic_frontend/providers/enterpriseInternship_provider.dart';
import 'package:pasantic_frontend/widgets/pasantias_empresa.dart';
import 'package:provider/provider.dart';


class IntershipsScreen extends StatefulWidget{

  const IntershipsScreen({Key? key}) : super(key: key);

  @override
  State<IntershipsScreen> createState() => _IntershipsScreenState();
}

class _IntershipsScreenState extends State<IntershipsScreen>{
  int currentIndex = 0;


  @override
  Widget build(BuildContext context){
    final internshipProvider = Provider.of<EnterpriseInternshipProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "PASANTIC",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: PasantiasEmpresaCards(
        pasantias: internshipProvider.internshipsResponses 
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