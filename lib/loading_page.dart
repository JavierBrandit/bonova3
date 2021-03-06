import 'package:flutter/material.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'src/pages/login/login_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/bv_login.png', height: 130),
                    SizedBox(height: 30),
                    CircularProgressIndicator(strokeWidth: 1)
                  ],
                ),
            );
          },
      )
          
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if ( autenticado ) {
      socketService.connect();
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_,__,___) => HomePage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      
      );
    } else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_,__,___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );  
    }

  }

}
  