import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula2_conectividade/city.dart';
import 'package:flutter_aula2_conectividade/geopoint.dart';
import 'package:flutter_aula2_conectividade/mapSample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(),
        '/map': (context) => MapSample(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    loadLakes();
  }

  List<City> cities;

  void loadLakes() async {
    try {
      Response response = await Dio().get("https://6039b3dfd2b9430017d244d4.mockapi.io/top_movies");

      if (response.statusCode == HttpStatus.ok){
        setState(() {
          cities = (response.data as List).map((item) => City.fromMap(item)).toList();
        });
      }

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("American Lakes"),
      ),
      body: cities == null ? LinearProgressIndicator() :
        ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return index % 2 == 0 ? evenCard(cities[index]) : oddCard(cities[index]);
          },
        )
    );
  }

  Card evenCard(City place) => Card(
    color: Colors.deepOrange,
    child: ListTile(
      title: Text(place.city),
      subtitle: Text(place.state),
      onTap: () {
        goToTheMap(place);
      },
    ),
  );

  Card oddCard(City place) => Card(
    color: Colors.green,
    child: ListTile(
      title: Text(place.city),
      subtitle: Text(place.state),
      onTap: () {
        goToTheMap(place);
      },
    ),
  );

  void goToTheMap(City city){
    Navigator.pushNamed(
       context,
       "/map",
        //o json de retorno do serviço fake retorna latitudes e longitues que
        //apontam para o meio do oceano. Para poder testar o mapa melhor,
        //pode descomentar a linha abaixo que possui lat/long de uma das mais
        //importantes cidades do RS
        //arguments: Geopoint(-28.388744, -51.850898)
      arguments: Geopoint(city.latitude, city.longitude)
    );
  }
}
