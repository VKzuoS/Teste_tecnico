import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth_services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc{
  final authService = AuthService();
  final facebook = FacebookLogin();
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth);

  Future<String> signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Logou";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String> signUp({String email, String password, String name, String bithday}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "criou";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Stream<User> get currentUser => authService.currentUser;

  loginFb() async{
    print('Login do Facebook');

    final res = await facebook.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userBirthday
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print('Sucesso');
        final FacebookAccessToken fbToken =res.accessToken;

        final AuthCredential credencia = FacebookAuthProvider.credential(fbToken.token);
        
        final result = await authService.singInWithCredential(credencia);

        print('${result.additionalUserInfo.profile} to aqui to aqui to aqui to aqui');

        break;
      case FacebookLoginStatus.cancel:
        print('cancelado');
        break;
      case FacebookLoginStatus.error:
        //print('deu erro');
        break;
    }
  }

  logout(){
    authService.logout();
  }
}
