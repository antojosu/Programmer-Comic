import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

void main() {
  runApp(ComicMain());
}

class ComicMain extends StatefulWidget {
  @override
  _ComicMainState createState() => _ComicMainState();
}

class _ComicMainState extends State<ComicMain> {
  String punchline = "Loading..";
  String setup = "Loading..";
  //List list = new List();
  var isLoading = false;
  @override
  void initState() {
    fetchJoke();
    super.initState();
  }

  double displayWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  fetchJoke() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get("https://official-joke-api.appspot.com/jokes/programming/random");
    if (response.statusCode == 200) {
      //list = json.decode(response.body) as List;
      final jsonResponse = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      for (var data in jsonResponse) {
        setup = data['setup'];
        punchline = data['punchline'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Programmer Comic",
        home: Scaffold(
          backgroundColor: Colors.amber,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Programmer Comic",
              style: TextStyle(fontFamily: 'BalooDa2', color: Colors.amber),
            ),
            backgroundColor: Colors.indigo[900],
          ),
          body: Container(
            margin: EdgeInsets.all(18),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                      color: Colors.indigo[900],
                      child: Container(
                        margin: EdgeInsets.all(18),
                        padding: EdgeInsets.all(10),
                        width: MediaQueryData.fromWindow(window).size.width,
                        child: Text(setup,
                            style: TextStyle(
                                fontFamily: 'BalooDa2',
                                fontSize: 20,
                                color: Colors.amber)),
                      )),
                  Card(
                      color: Colors.indigo[900],
                      child: Container(
                        margin: EdgeInsets.all(18),
                        padding: EdgeInsets.all(10),
                        width: MediaQueryData.fromWindow(window).size.width,
                        child: Text(punchline,
                            style: TextStyle(
                                fontFamily: 'BalooDa2',
                                fontSize: 20,
                                color: Colors.amber)),
                      ))
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo[900],
            onPressed: () => fetchJoke(),
            child: Icon(
              Icons.refresh,
              color: Colors.amber,
            ),
          ),
        ));
  }
}
