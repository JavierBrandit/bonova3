import 'package:flutter/material.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'home_page.dart';
import 'src/pages/login/login_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pantalla = MediaQuery.of(context).size;  

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:SystemUiOverlayStyle(
             statusBarColor: Colors.transparent, //i like transaparent :-)
             systemNavigationBarColor: Color(0xFF00DEBF), // navigation bar color
             systemNavigationBarDividerColor: Color(0xFF00DEBF), // navigation bar color
             statusBarIconBrightness: Brightness.dark, // status bar icons' color
             systemNavigationBarIconBrightness:Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF00DEBF),
        body: FutureBuilder(
            future: checkLoginState(context),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(height: pantalla.height * .1),
                      Image.asset('assets/foreground.png', height: 150),
                      SizedBox(height: pantalla.height * .2),
                      // SizedBox(height: pantalla.height * .15),
                      // SizedBox(height: 60),
                      
                      Hero(
                        tag: 'logo',
                        child: WebsafeSvg.asset('assets/bv_ic.svg',
                          height: 35,
                          color: Color(0xFF005447),
                        ),
                      ),
                      SizedBox(height: pantalla.height * .05),
                      
                      Container(
                        width: 80,
                        // padding: EdgeInsets.symmetric(horizontal: 180),
                        child: LinearProgressIndicator(backgroundColor: Colors.teal[800], minHeight: 1.3,),
                      ),
                      SizedBox(height: pantalla.height * .16),

                    ],
                  ),
              );
            },
        )
            
      ),
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if ( autenticado ) {
      socketService.connect();
      
      SchedulerBinding.instance.addPostFrameCallback((_) {

      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_,__,___) => HomePage(),
          transitionDuration: Duration(milliseconds: 200)
        )
      
      );
    });
    } else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_,__,___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 200)
        )
      );  
    }

  }


}
  