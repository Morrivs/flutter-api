import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaPrediccionGenero extends StatefulWidget {
  @override
  _PantallaPrediccionGeneroState createState() => _PantallaPrediccionGeneroState();
}

class _PantallaPrediccionGeneroState extends State<PantallaPrediccionGenero> {
  TextEditingController _controladorNombre = TextEditingController();
  String _genero = '';
  bool _cargando = false;

  Future<void> _predecirGenero(String nombre) async {
    setState(() {
      _cargando = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$nombre'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _genero = data['gender'].toString().toLowerCase();
        _cargando = false;
      });
    } else {
      setState(() {
        _genero = 'error';
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorNombre,
              decoration: InputDecoration(
                labelText: 'Ingrese un nombre',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _predecirGenero(_controladorNombre.text),
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20.0),
            _cargando
                ? CircularProgressIndicator()
                : _genero == 'male'
                    ? Image.asset('assets/azul.png')
                    : _genero == 'female'
                        ? Image.asset('assets/rosa.png')
                        : Container(),
          ],
        ),
      ),
    );
  }
}
