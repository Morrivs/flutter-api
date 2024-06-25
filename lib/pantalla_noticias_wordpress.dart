import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'noticias_services.dart';

class PantallaNoticiasWordPress extends StatefulWidget {
  @override
  _PantallaNoticiasWordPressState createState() => _PantallaNoticiasWordPressState();
}

class _PantallaNoticiasWordPressState extends State<PantallaNoticiasWordPress> {
  NoticiasService _noticiasService = NoticiasService();
  List<dynamic> _noticias = [];

  @override
  void initState() {
    super.initState();
    _cargarUltimasNoticias();
  }

  Future<void> _cargarUltimasNoticias() async {
    try {
      List<dynamic> noticias = await _noticiasService.getUltimasNoticias();
      setState(() {
        _noticias = noticias.take(3).toList(); // Limitamos a las primeras 3 noticias
      });
    } catch (e) {
      print('Error al cargar las noticias: $e');
      // Manejar el error aquí, por ejemplo, mostrar un mensaje al usuario
    }
  }

  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  void _abrirUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar la URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de O&M'),
      ),
      body: _noticias.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _noticias.length + 1, // +1 para incluir la imagen como primer elemento
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Mostrar la imagen local como primer elemento
                  return Container(
                    height: 200, // Ajustar la altura según sea necesario
                    child: Image.asset(
                      'assets/oym.png', // Ruta de la imagen local en tu proyecto
                      fit: BoxFit.cover,
                      width: 300
                    ),
                  );
                } else {
                  // Mostrar las noticias
                  final noticiasIndex = index - 1; // Ajustar el índice para las noticias
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        _abrirUrl(_noticias[noticiasIndex]['link']);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              removeHtmlTags(_noticias[noticiasIndex]['title']['rendered']),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              removeHtmlTags(_noticias[noticiasIndex]['content']['rendered']),
                              maxLines: 2, // Puedes ajustar el número de líneas a mostrar
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Leer más', // Puedes personalizar este texto
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
