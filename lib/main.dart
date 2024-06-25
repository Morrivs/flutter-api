import 'package:flutter/material.dart';
import 'pantalla_prediccion_genero.dart';
import 'pantalla_prediccion_edad.dart';
import 'pantalla_lista_universidades.dart';
import 'pantalla_noticias_wordpress.dart';
import 'pantalla_clima.dart';
import 'pantalla_acerca_de.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/prediccion-genero': (context) => PantallaPrediccionGenero(),
        '/prediccion-edad': (context) => PantallaPrediccionEdad(),
        '/lista-universidades': (context) => PantallaListaUniversidades(),
        '/clima': (context) => PantallaClima(),
        '/noticias-wordpress': (context) => PantallaNoticiasWordPress(),
        '/acerca-de': (context) => PantallaAcercaDe(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Toolbox'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prediccion-genero');
              },
              child: Text('Predicción de Género'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prediccion-edad');
              },
              child: Text('Predicción de Edad'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lista-universidades');
              },
              child: Text('Lista de Universidades'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clima');
              },
              child: Text('Clima en República Dominicana'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/noticias-wordpress');
              },
              child: Text('Noticias de la O&M'),
            ),
                        SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/acerca-de'); // Nueva opción para Acerca de
              },
              child: Text('Acerca de'),
            ),
          ],
        ),
      ),
    );
  }
}
