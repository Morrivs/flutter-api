import 'dart:convert';
import 'package:http/http.dart' as http;

class NoticiasService {
  Future<List<dynamic>> getUltimasNoticias() async {
    String apiUrl = 'https://www.udoym.edu.do/wp-json/wp/v2/posts';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> noticias = jsonDecode(response.body);
      return noticias;
    } else {
      throw Exception('Failed to load noticias');
    }
  }
}
