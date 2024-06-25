import 'package:flutter/material.dart';

class PantallaAcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/perfil.jpg'), 
            ),
            SizedBox(height: 20),
            Text(
              'Richard Andres Montero Ogando',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Desarrollador de Aplicaciones',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Contacto: rmontero1235@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Teléfono: 829-902-7902',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
