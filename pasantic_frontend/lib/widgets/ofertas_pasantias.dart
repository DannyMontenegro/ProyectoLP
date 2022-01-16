// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pasantic_frontend/helpers/getDiffTime.dart';

class PasantiasCards extends StatefulWidget {
  final List<Internship> pasantias;
  final Function onNextPagePasantias;

  const PasantiasCards(
      {Key? key, required this.pasantias, required this.onNextPagePasantias})
      : super(key: key);

  @override
  State<PasantiasCards> createState() => _PasantiasCardsState();
}

class _PasantiasCardsState extends State<PasantiasCards> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPagePasantias();
      }
    });
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.pasantias.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCardOffer(pasantia: widget.pasantias[index]);
        });
  }
}

class CustomCardOffer extends StatefulWidget {
  final Internship pasantia;
  const CustomCardOffer({Key? key, required this.pasantia}) : super(key: key);

  @override
  State<CustomCardOffer> createState() => _CustomCardOfferState();
}

class _CustomCardOfferState extends State<CustomCardOffer> {
  dynamic enterprise;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _getEnterprise(widget.pasantia.idEnterprise);
    print(widget.pasantia.dateFrom);
    print(widget.pasantia.dateTo);
    return Container(
      width: size.width * 0.8,
      child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
                          widget.pasantia.title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      child: Text('Company:'),
                      alignment: Alignment.center,
                      constraints: BoxConstraints(minWidth: 250),
                    ),
                    Container(
                      child: Text(
                        enterprise != null
                            ? enterprise['User']['name']
                            : 'Empresa',
                        style: TextStyle(color: Colors.orange.shade400),
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
                      constraints: BoxConstraints(minWidth: 245),
                    ),
                    Container(
                      child: Text(
                        widget.pasantia.location,
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
                      constraints: BoxConstraints(minWidth: 230),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Text(
                        '\$${widget.pasantia.payment}/mes',
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
                      constraints: BoxConstraints(minWidth: 230),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Text(
                        '${getDiffYMD(widget.pasantia.dateFrom,widget.pasantia.dateTo)} meses',
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
    );
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
