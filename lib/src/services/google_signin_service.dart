import 'dart:convert';

import 'package:bonova0002/src/global/environment.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class GoogleSignInService {

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );


  static Future<GoogleSignInAccount> signInWithGoogle() async {

    try {

      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;
      final String token = googleKey.idToken.trim();
      print(account);
      print('======== ID TOKEN ========= ');
      print( token );


      // TODO: Llamar un servicio REST a nuestro backend


      // final data = {
      //     'token': token
      // };

      // final resp = await http.post('${ Environment.apiUrl }/login/google',
      //   body: {
      //     'token': token
      //   },
      // );

      final signInWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'bonova-backend-beta.herokuapp.com',
        path: '/api/login/google'
      );

      final session = await http.post(
        signInWithGoogleEndpoint,
        body: {
          'token': token
        }
      );

      print('====== backend =======');
      // print( resp.body );
      print( session.body );


      return account;

      
    } catch (e) {
      print('Error en google Signin');
      print(e);
      return null;
    }

  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

}