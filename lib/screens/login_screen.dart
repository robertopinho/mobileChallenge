import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobilechallenge/api/login_api.dart';
import 'package:mobilechallenge/models/usuario_model.dart';
import 'package:mobilechallenge/screens/cadastro_screen.dart';
import 'package:mobilechallenge/widgets/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();

  bool _checkBox = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    autoLogin();
  }

  void saveLogin(Usuario user) async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    if (_checkBox) {
      sh.setString('email', user.email);
      sh.setString('senha', _ctrlSenha.text);
    } else {
      sh.clear();
    }
  }

  void autoLogin() async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    final String email = sh.getString('email');
    final String senha = sh.getString('senha');
    if (email != null && senha != null) {
      _ctrlLogin.text = email;
      _ctrlSenha.text = senha;
      _clickButton(context);
    }
  }

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
              'Faça o login abaixo.',
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                          color: Colors.lightGreen[900], fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.lightGreen[900],
                        value: _checkBox,
                        onChanged: (bool newValue) {
                          setState(() {
                            _checkBox = newValue;
                          });
                        }),
                    Text(
                      "Mantenha-me logado",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'LOGAR',
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.white,
                color: Colors.lightGreen[900],
                onPressed: () {
                  _clickButton(context);
                }),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Text(
                  "Ainda não possui uma conta?",
                  style: TextStyle(fontSize: 16),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CadastroScreen()));
                  },
                  child: Text(
                    'Crie uma aqui!',
                    style: TextStyle(
                        color: Colors.lightGreen[900],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;
    var usuario = await LoginApi.login(login, senha);
    if (usuario != null) {
      if (_checkBox) {
        saveLogin(usuario);
      }
      _navegaHomepage(context, usuario);
    } else {
      alert(context, "login inválido!");
    }
  }

  _navegaHomepage(BuildContext context, Usuario user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage(user)));
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
