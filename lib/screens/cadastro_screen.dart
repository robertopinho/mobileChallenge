import 'package:flutter/material.dart';
import 'package:mobilechallenge/api/cadastro_api.dart';
import 'package:mobilechallenge/widgets/alert.dart';

class CadastroScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _ctrlNome = TextEditingController();
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage('images/icon.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Olá',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.lightGreen[900],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 120, 0))
                ],
              ),
            ],
          ),
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              'Faça cadastro abaixo.',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                _textFormField('Nome Completo',
                    controller: _ctrlNome, validator: _validacao),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "E-mail",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                _textFormField('maria@gmail.com',
                    controller: _ctrlLogin, validator: _validacao),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Senha',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _textFormField('*********',
                    senha: true, controller: _ctrlSenha, validator: _validacao),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'CRIAR CONTA',
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.white,
                color: Colors.lightGreen[900],
                onPressed: () {
                  _clickButton(context);
                }),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Voltar',
                  style: TextStyle(
                      color: Colors.lightGreen[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _validacao(String texto) {
    if (texto.isEmpty) {
      return "Preencha este campo.";
    }
    return null;
  }

  _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }
    String nome = _ctrlNome.text;
    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;
    var usuario = await CadastroApi.cadastro(nome, login, senha);
    if (usuario != null) {
      Navigator.of(context).pop();

      // alert(context, 'Cadastro efetuado com sucesso.');

    } else {
      alert(context, "Cadastro Inválido!");
    }
  }

  _textFormField(
    String hint, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: senha,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
