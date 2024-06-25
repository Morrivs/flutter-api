import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaClima extends StatefulWidget {
  @override
  _PantallaClimaState createState() => _PantallaClimaState();
}

class _PantallaClimaState extends State<PantallaClima> {
  String _clima = '';
  bool _cargando = false;

  Future<void> _buscarClima() async {
    setState(() {
      _cargando = true;
    });

    final apiKey = '17d2a79749a8035b8cdcb1e6d6f2a637'; // Reemplaza con tu propia clave API de OpenWeatherMap
    final ciudad = 'santo%20domingo'; // Ejemplo: Santo Domingo, República Dominicana
    final endpoint = 'https://api.openweathermap.org/data/2.5/weather?q=$ciudad&lang=es&appid=$apiKey';

    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _clima = data['weather'][0]['description'];
        _cargando = false;
      });
    } else {
      setState(() {
        _clima = 'Error al obtener el clima';
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Actual'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _buscarClima(),
              child: Text('Buscar Clima'),
            ),
            SizedBox(height: 20.0),
            _cargando
                ? CircularProgressIndicator()
                : Text(
                    'Clima Actual: $_clima',
                    style: TextStyle(fontSize: 20.0),
                  ),
          ],
        ),
      ),
    );
  }
}
