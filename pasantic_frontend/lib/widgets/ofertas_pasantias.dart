// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PasantiasCards extends StatelessWidget {
  const PasantiasCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return CustomCardOffer();
        });
  }
}

class CustomCardOffer extends StatelessWidget{
  const CustomCardOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.white70,
        
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            
            children: [
              SizedBox(height: 10),
              
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 150),
                    alignment: Alignment.center,
                    child: Text('IOS DEVELOPER',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),)),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  )
                  
                ],),
      
              SizedBox(height: 10),

              Row(
                children: [
                  Container(
                    child: Text('Company:'),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minWidth: 250),
                  ),
                  Container(
                    child: Text('Espol',
                      style: TextStyle(color: Colors.orange.shade400),),
                  )
                ],
              ),

              SizedBox(height: 10),
              
              Row(
                children: [
                  Container(
                    child: Text('Location:'),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minWidth: 245),
                  ),
                  Container(
                    child: Text('Guayaquil',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.orange.shade400),),
                  )
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Container(
                    child: Text('Salary:'),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minWidth: 230),
                  ),

                  SizedBox(width: 15,),

                  Container(
                    child: Text('\$300/mes',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),),
                  )
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Container(
                    child: Text('Period:'),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minWidth: 230),
                  ),

                  SizedBox(width: 15,),

                  Container(
                    child: Text('6 meses',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),),
                  )
                ],
              ),

              SizedBox(height: 10),
            ],),
        )

      ),
    );
  }

}

class CustomCardBurguer extends StatelessWidget {
  const CustomCardBurguer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white70,
        elevation: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(2.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.28,
                  maxHeight: MediaQuery.of(context).size.width * 0.28,),
                child: Image.asset('assets/avatar_image.jpg',
                  fit: BoxFit.fill),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text('Texas Angus Burger',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Text(
                      '100% Australian Angus grain-fed beef with cheese and pickles.  Served with fries.',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 40, 0, 0),
                    child: Text(
                      '\$ 24.00',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
          ],
          ),
          ]
        ),
      )
    );
  }
}
