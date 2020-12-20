import 'dart:convert';
import 'package:mobilechallenge/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class CadastroApi {
  static Future<Usuario> cadastro(String nome, String email, String senha) async {
    var url = "http://robertoopinho.pythonanywhere.com/usuarios";
    var header = {"Content-Type": "application/json"};
    Map params = {
      "nome": nome,
      "email": email,
      "senha": senha,
    };
    var usuario;
    var _body = json.encode(params);
    var response = await http.post(url, headers: header, body: _body);
    Map mapResponse = json.decode(response.body);

    print('Código access_token >>> ${mapResponse['access_token']}');
    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 201) {
      usuario = Usuario.fromJson(mapResponse);

      print(usuario);
    } else {
      usuario = null;
      print(usuario);
    }
    return usuario;
  }

}