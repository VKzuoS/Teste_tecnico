import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/pages/tmdb.dart';
import 'package:provider/provider.dart';

import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(FirebaseAuth.instance),
      child: MaterialApp(
        title: 'Teste Tecnico',
        home: AthenticationWrapper(),
      ),
    );
  }
}

class AthenticationWrapper extends StatelessWidget {
  const AthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
