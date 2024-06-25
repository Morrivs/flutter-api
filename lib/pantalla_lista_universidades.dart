import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PantallaListaUniversidades extends StatefulWidget {
  @override
  _PantallaListaUniversidadesState createState() => _PantallaListaUniversidadesState();
}

class _PantallaListaUniversidadesState extends State<PantallaListaUniversidades> {
  TextEditingController _controladorPais = TextEditingController();
  List<dynamic> _universidades = [];
  bool _cargando = false;

  Future<void> _buscarUniversidades(String pais) async {
    setState(() {
      _cargando = true;
    });

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$pais'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _universidades = data;
        _cargando = false;
      });
    } else {
      setState(() {
        _universidades = [];
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorPais,
              decoration: InputDecoration(
                labelText: 'Ingrese un país',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _buscarUniversidades(_controladorPais.text),
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20.0),
            _cargando
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _universidades.length,
                      itemBuilder: (context, index) {
                        var uni = _universidades[index];
                        return ListTile(
                          title: Text(uni['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dominio: ${uni['domains'].join(', ')}'),
                              Text('Sitio web: ${uni['web_pages'].join(', ')}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
