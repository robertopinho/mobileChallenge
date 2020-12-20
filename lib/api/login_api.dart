import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilechallenge/models/usuario_model.dart';

class LoginApi {
  static Future<Usuario> login(String email, String senha) async {
    var url = "http://robertoopinho.pythonanywhere.com/login";
    var header = {"Content-Type": "application/json"};
    Map params = {
      "email": email,
      "senha": senha,
    };
    var usuario;
    var _body = json.encode(params);
    var response = await http.post(url, headers: header, body: _body);
    Map mapResponse = json.decode(response.body);

    print('Código access_token >>> ${mapResponse['access_token']}');
    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      usuario = Usuario.fromJson(mapResponse);

      print(usuario);
    } else {
      usuario = null;
      print(usuario);
    }
    return usuario;
  }
}
