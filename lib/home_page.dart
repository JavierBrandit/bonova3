import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'src/pages/explore/explore_page.dart';
import 'src/pages/inicio/inicio_page.dart';
import 'src/pages/user/user_page.dart';

  int currentIndex = 0;


  class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          extendBody: true,
          body: _callPage(currentIndex),
          bottomNavigationBar: _crearBNBar(),
        );
      }

      Widget _callPage( int paginaActual ) {
        switch( paginaActual ) {
          case 0: return InicioPage();
          case 1: return ExplorePage();
          case 2: return UserPage();
          default: return InicioPage();
        }
      }




      Widget _crearBNBar() {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 52 ),
          child: Container(
            decoration: BoxDecoration( boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.013),
              blurRadius: 20
            )]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                elevation: 0,
                //backgroundColor: Colors.white,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                items: [
                  BottomNavigationBarItem(
                      icon: (currentIndex == 0)
                          ? Icon(FluentSystemIcons.ic_fluent_home_filled, size: 25, )
                          : Icon(FluentSystemIcons.ic_fluent_home_regular, size: 25, color: Colors.grey,),
                      title: Container()
                  ),
                  BottomNavigationBarItem(
                      icon: (currentIndex == 1)
                          ? Icon(FluentSystemIcons.ic_fluent_search_filled, size: 25,)
                          : Icon(FluentSystemIcons.ic_fluent_search_regular, size: 25, color: Colors.grey),
                      title: Container()
                  ),
                  BottomNavigationBarItem(
                      icon: (currentIndex == 2)
                          ? Icon(FluentSystemIcons.ic_fluent_person_filled, size: 25,)
                          : Icon(FluentSystemIcons.ic_fluent_person_regular, size: 25, color: Colors.grey),
                      title: Container()
                  ),






                  ],
                ),
              ),
          ),
        );
      }
}
