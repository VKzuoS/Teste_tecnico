import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth_services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc{
  final authService = AuthService();
  final facebook = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;

  loginFb() async {
    print('Login do Facebook');

    final res = await facebook.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userBirthday
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print('Sucesso');
        break;
      case FacebookLoginStatus.cancel:
        print('cancelado');
        break;
      case FacebookLoginStatus.error:
        print('deu erro');
        break;
    }
  }
}
