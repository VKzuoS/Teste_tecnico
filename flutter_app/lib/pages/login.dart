//import 'dart:async';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/singup_page.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    var usuario = Provider.of<AuthBloc>(context, listen: false).authService;
    usuario.currentUser.listen((logado) {
      if (logado != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Senha'),
              ),
              RaisedButton(
                  child: Text('Entrar'),
                  onPressed: () {
                    context.read<AuthBloc>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                    /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    )); */
                  }),
              RaisedButton(
                child: Text('Criar conta'),
                onPressed: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SingUpPage(),
                )),
              ),
              RaisedButton(
                child: Text('Login com Facebook'),
                color: Colors.blueAccent,
                onPressed: () => authBloc.loginFb(),
              ),
            ],
          ),
        ));
  }
}
