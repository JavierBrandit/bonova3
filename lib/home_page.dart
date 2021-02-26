import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/pages/inicio/chat_page.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'src/pages/explore/explore_page.dart';
import 'src/pages/inicio/inicio_page.dart';
import 'src/pages/user/actividad.dart';
import 'src/pages/user/user_page.dart';
import 'src/widgets/reproductor_video.dart';

  int currentIndex = 0;
  VideoService vservice;


  class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    vservice = Provider.of<VideoService>(context);
    final curso = vservice.getCurso(); 
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;


    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          _callPage(currentIndex),
          _crearBNBar(isDarkTheme)
        ]
      // bottomNavigationBar: _crearBNBar(),
    );
  }

  Widget _callPage( int paginaActual ) {
    switch( paginaActual ) {
      case 0: return InicioPage();
      case 1: return ExplorePage();
      // case 2: return PlayPage(clips: videos);
      case 2: return Actividad();
      case 3: return Actividad();
      case 4: return UserPage();
      default: return InicioPage();
    }
  }




  Widget _crearBNBar(bool dark) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: dark? BonovaColors.azulNoche[800] : Colors.grey[50],
        // border: Border.symmetric( horizontal: BorderSide( width: 1, color: Colors.white))
        border: Border( top: BorderSide( width: .1, color: dark? Colors.white60 : Colors.grey[700] ))
      ),
      // padding: EdgeInsets.symmetric( horizontal: 10),
      child: BottomNavigationBar(
        iconSize: 27,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [

          BottomNavigationBarItem(
              icon: (currentIndex == 0)
                  ? Icon(FluentIcons.home_16_filled)
                  : Icon(FluentIcons.home_16_regular),
              title: Container()
          ),

          BottomNavigationBarItem(
              icon: (currentIndex == 1)
                  ? Icon(FluentIcons.search_24_filled)
                  : Icon(FluentIcons.search_24_filled),
              title: Container()
          ),

          BottomNavigationBarItem(
              icon: (currentIndex == 2)
                  ? Icon(FluentIcons.play_circle_24_filled, size: 30)
                  : Icon(FluentIcons.play_circle_24_regular, size: 30),
              title: Container()
          ),
          BottomNavigationBarItem(
              icon: (currentIndex == 3)
                  ? Icon(FluentIcons.hat_graduation_16_filled)
                  : Icon(FluentIcons.hat_graduation_16_regular),
              title: Container()
          ),
          BottomNavigationBarItem(
              icon: (currentIndex == 4)
                  ? Icon(FluentIcons.person_16_filled, size: 29)
                  : Icon(FluentIcons.person_16_regular, size: 29),
              title: Container()
          ),


          ],
              
      ),
    );
  }
}
