import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasantic_frontend/helpers/getDiffTime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pasantic_frontend/providers/user_provider.dart';
import 'package:pasantic_frontend/models/internship_model.dart';

class PasantiasEmpresaCards extends StatefulWidget {
  final List<Internship> pasantias;

  const PasantiasEmpresaCards({
    Key? key,
    required this.pasantias,
  }) : super(key: key);

  @override
  State<PasantiasEmpresaCards> createState() => _PasantiasEmpresaCardsState();
}

class _PasantiasEmpresaCardsState extends State<PasantiasEmpresaCards> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? id = prefs.getInt('id');
        String data = await User.getUserById('$id');
        if (json.decode(data)['payload']['user']['role'] == "empresa") {
          Navigator.pushNamed(context, 'details_enterprise',
              arguments: widget.pasantia);
        } else {
          Navigator.pushNamed(context, 'details', arguments: widget.pasantia);
        }
      },
      child: SizedBox(
        width: size.width,
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.white70,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                          constraints: const BoxConstraints(minWidth: 150),
                          alignment: Alignment.center,
                          child: Text(
                            widget.pasantia.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        child: const Text('Location:'),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 145),
                      ),
                      Text(
                        widget.pasantia.location,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.orange.shade400),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        child: const Text('Salary:'),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 130),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '\$${widget.pasantia.payment}/mes',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        child: const Text('Period:'),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 132),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${getDiffYMD(widget.pasantia.dateFrom, widget.pasantia.dateTo)} meses',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }
}
