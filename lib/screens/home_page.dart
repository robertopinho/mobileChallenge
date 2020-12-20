import 'package:flutter/material.dart';
import 'package:mobilechallenge/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final Usuario user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      final SharedPreferences sh = await SharedPreferences.getInstance();
      sh.clear();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logOut();
            }),
      ),
      body: ListView(
        children: [
          Container(
            height: 170,
            child: Stack(
              children: [
                Center(
                  child: Image(
                    image: AssetImage('images/icon.png'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Seja bem vindo(a)',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8, top: 10),
            padding: EdgeInsets.fromLTRB(20, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome: ${user.nome}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'E-mail: ${user.email}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
