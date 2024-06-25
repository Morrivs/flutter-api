import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaPrediccionEdad extends StatefulWidget {
  @override
  _PantallaPrediccionEdadState createState() => _PantallaPrediccionEdadState();
}

class _PantallaPrediccionEdadState extends State<PantallaPrediccionEdad> {
  TextEditingController _controladorNombre = TextEditingController();
  String _grupoEdad = '';
  int _edad = 0;
  bool _cargando = false;

  Future<void> _predecirEdad(String nombre) async {
    setState(() {
      _cargando = true;
    });

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _edad = data['age'] ?? 0;
        _cargando = false;
        _establecerGrupoEdad(_edad);
      });
    } else {
      setState(() {
        _grupoEdad = 'error';
        _cargando = false;
      });
    }
  }

  void _establecerGrupoEdad(int edad) {
    if (edad <= 20) {
      _grupoEdad = 'joven';
    } else if (edad > 20 && edad <= 60) {
      _grupoEdad = 'adulto';
    } else {
      _grupoEdad = 'anciano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
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
              onPressed: () => _predecirEdad(_controladorNombre.text),
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20.0),
            _cargando
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text('Edad: $_edad'),
                      SizedBox(height: 10.0),
                      if (_grupoEdad == 'joven')
                        Image.asset('assets/joven.png',
                        width: 150,)
                      else if (_grupoEdad == 'adulto')
                        Image.asset('assets/adulto.png',
                        width: 150,)
                      else if (_grupoEdad == 'anciano')
                        Image.asset('assets/anciano.png',
                        width: 150,),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
