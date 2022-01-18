// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/models/models.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pasantic_frontend/helpers/getDiffTime.dart';

class PostulacionesCards extends StatefulWidget {
  final dynamic pasantias;

  const PostulacionesCards({Key? key, required this.pasantias})
      : super(key: key);

  @override
  State<PostulacionesCards> createState() => _PostulacionesCardsState();
}

class _PostulacionesCardsState extends State<PostulacionesCards> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.pasantias.length == 0)
      return Text("No ha postulado a pasantias");
    return ListView.builder(
        itemCount: widget.pasantias.length,
        itemBuilder: (BuildContext context, int index) {
          print(widget.pasantias[index]);
          return CustomCardOffer(pasantia: widget.pasantias[index]);
          // return CustomCardOffer(pasantia: widget.pasantias[index]);
        });
  }
}

class CustomCardOffer extends StatefulWidget {
  final dynamic pasantia;
  const CustomCardOffer({Key? key, required this.pasantia}) : super(key: key);

  @override
  State<CustomCardOffer> createState() => _CustomCardOfferState();
}

class _CustomCardOfferState extends State<CustomCardOffer> {
  dynamic enterprise;
  dynamic pasantiaData;
  Color statusColor = Colors.blue;

  @override
  void initState() {
    print("PasantiaStudent: ${widget.pasantia}");
    if (widget.pasantia["status"] == "Aprobado") {
      statusColor = Colors.green;
    }
    if (widget.pasantia["status"] == "Denegado") {
      statusColor = Colors.red;
    }
    super.initState();
    _getInternship();
    setState(() {});
  }

  void _getInternship() async {
    dynamic idInternship = widget.pasantia['idInternship'];
    String _baseUrl = '10.0.2.2:3001';
    var url = Uri.http(_baseUrl, '/internships/$idInternship');
    final response = await http.get(url);
    final jsonData = response.body;
    pasantiaData = json.decode(jsonData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (pasantiaData != null) {
      _getEnterprise(pasantiaData["payload"]['internship']["Enterprise"]["id"]);
      context.loaderOverlay.hide();
      return GestureDetector(
        child: Container(
          width: size.width,
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
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
                            child: Text(
                              pasantiaData["payload"]['internship']['title'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          child: Text('Empresa:'),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 150),
                        ),
                        Container(
                          child: Text(
                            enterprise != null
                                ? enterprise['User']['name']
                                : 'Empresa',
                            style: TextStyle(
                                color: Colors.orange.shade400,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          child: Text('Correo:'),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 135),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          child: Text(
                            enterprise != null
                                ? enterprise['User']['email']
                                : 'Empresa',
                            style: TextStyle(
                                color: Colors.orange.shade400,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          child: Text('Location:'),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 145),
                        ),
                        Container(
                          child: Text(
                            pasantiaData["payload"]['internship']['location'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.orange.shade400),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          child: Text('Salary:'),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 130),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Text(
                            '\$${pasantiaData["payload"]['internship']['payment']}/mes',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          child: Text('Period:'),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 132),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Text(
                            '${getDiffYMD(DateTime.parse(pasantiaData["payload"]['internship']['dateFrom']), DateTime.parse(pasantiaData["payload"]['internship']['dateTo']))} meses',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )),
        ),
      );
    }
    print("No hay data");
    return Text("Esperando la informacion");
  }

  _getEnterprise(int id) async {
    const String baseUrl = '10.0.2.2:3001';
    String segment = '/enterprises/$id';
    var url = Uri.http(baseUrl, segment);
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    setState(() => enterprise = jsonData['payload']['enterprise']);
  }
}
