import 'package:flutter/material.dart';
import 'package:mercado/src/get_mercados.dart';

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  TextEditingController loginController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bem-vindo'),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.blue.shade200,
        body: Container(
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: ListView(
                children: [
                  Image.asset('images/logo.png', height: 200, width: 200),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: loginController,
                      decoration: InputDecoration(
                          labelText: 'Login',
                          hintText: 'Digite o seu login',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String login = loginController.text;
                      String senha = senhaController.text;
                      if (login == 'admin' && senha == 'admin') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetMercado()));
                      } else {
                        setState(() {
                          showDialog(
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('Erro!'),
                                    content: Text('Login ou Senha Invalida'));
                              },
                              context: context);
                        });
                      }
                    },
                    child: Text('Login'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
