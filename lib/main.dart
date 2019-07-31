import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Map<String, dynamic> data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://pizzariamarcola.000webhostapp.com/lista-pcs.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Sucesso";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:
          AppBar(title: Text("Lista de Pizza"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: data == null ? 0 : data['pcs'].length,
        itemBuilder: (BuildContext context, int index) {
          print(data['pcs'].length);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: data['pcs'][index]["imagem"] != ""
                            ? Image.network(
                                data['pcs'][index]["imagem"],
                                width: 100,
                              )
                            : Container(
                          width: 100,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 250,color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 4.5),
                              child: Text(
                                data['pcs'][index]["modelo"],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20,
                                color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10, right: 5),child:
                          Container(
                            child: Text(
                              "Configurações: ${data['pcs'][index]["configurações"]}",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 17.5
                              ),
                            ),
                            width: 250,
                          ),)
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
