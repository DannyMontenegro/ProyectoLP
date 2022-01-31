import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:pasantic_frontend/models/internship_student_model.dart';
import 'package:http/http.dart' as http;

class StudentIntershipWidget extends StatefulWidget {
  final List students;

  const StudentIntershipWidget({
    Key? key,
    required this.students,
  }) : super(key: key);

  @override
  State<StudentIntershipWidget> createState() =>
      _StudentsPasantiasEmpresaCardsState();
}

class _StudentsPasantiasEmpresaCardsState
    extends State<StudentIntershipWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.students.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCardOffer(student: widget.students[index]);
        });
  }
}

class CustomCardOffer extends StatefulWidget {
  final student;

  const CustomCardOffer({Key? key, required this.student}) : super(key: key);

  @override
  State<CustomCardOffer> createState() => _CustomCardOfferState();
}

class _CustomCardOfferState extends State<CustomCardOffer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var idEstudiante = widget.student["idStudent"];
    var idPasantia = widget.student["idInternship"];
    return GestureDetector(
      onTap: () async {
        int id = widget.student["idStudent"];
        print(id);
        String data = await getUserById('$id');
        /*
        if (json.decode(data)['payload']['user']['role'] == "empresa") {
          print("hello");
        } else {
          print("hello");
        }
        */
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 150),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                                constraints:
                                    const BoxConstraints(minWidth: 150),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.student["estudiante"]["name"],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              child: const Text('Correo:'),
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(minWidth: 145),
                            ),
                            Text(
                              widget.student["estudiante"]["email"].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.orange.shade400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Row(children: [
                        IconButton(
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          tooltip: 'Accept',
                          onPressed: () async {
                            const String baseUrl = '10.0.2.2:3001';
                            //const String baseUrl = '192.168.56.1:3001';
                            const String segment =
                                '/internshipStudent/studentAccept';
                            var url = Uri.http(baseUrl, segment);

                            final body = {
                              'idStudent': '$idEstudiante',
                              'idInternship': '$idPasantia'
                            };
                            final jsonString = json.encode(body);
                            final response = await http.put(url,
                                headers: {"Content-Type": "application/json"},
                                body: jsonString);
                            final jsonDecoded = json.decode(response.body);
                            if (jsonDecoded['status'] == "200" ||
                                jsonDecoded['status'] == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Se ha aceptado.')));
                            } else {
                              print(jsonDecoded);
                              print(widget.student);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Error al aceptar")));
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.highlight_remove_outlined,
                            color: Colors.red,
                          ),
                          tooltip: 'Remove',
                          onPressed: () {
                            print("Remove");
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_time_outlined,
                            color: Colors.grey,
                          ),
                          tooltip: 'Put to wait',
                          onPressed: () {
                            print("waitting");
                          },
                        ),
                      ])),
                ],
              ),
            )),
      ),
    );
  }
}

getUserById(String id) async {
  var url = Uri.http('10.0.2.2:3001', '/students/$id');
  //var url = Uri.http('192.168.56.1:3001', '/users/$id');

  final response = await http.get(url);
  final jsonData = response.body;
  return jsonData;
}
