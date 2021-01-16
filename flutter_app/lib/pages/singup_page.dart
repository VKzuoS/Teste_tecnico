import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:provider/provider.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar Conta'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Nome'),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: birthController,
                decoration: InputDecoration(hintText: 'Data de Nascimento'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Senha'),
              ),
              RaisedButton(
                  child: Text('Entrar'),
                  onPressed: () {
                    context.read<AuthBloc>().signUp(//Atualizar estados com essa informação
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      birthday: birthController.text.trim(),
                      name: nameController.text.trim(),
                    );

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  }),
            ],
          ),
        ));
  }
}