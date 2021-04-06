import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/pages/explore/busqueda.dart';
import 'package:bonova0002/src/pages/inicio/chat_page.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/models/historial.dart';
import 'src/pages/explore/explore_page.dart';
import 'src/pages/inicio/inicio_page.dart';
import 'src/pages/player/mis_cursos.dart';
import 'src/pages/player/reproductor_video.dart';
import 'src/pages/user/actividad.dart';
import 'src/pages/user/user_page.dart';
import 'src/services/auth_services.dart';

  int currentIndex = 0;
  CursoService cservice;
  AuthService auth = AuthService();
  bool reproduciendo = false;
  bool disposed = false;
  Historial historial;
  List<Historial> hist;


  class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    cservice = Provider.of<CursoService>(context);
    // final curso = cservice.getCurso(); 
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;



    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        sized: false,
        value:SystemUiOverlayStyle(
               statusBarColor: Colors.transparent, //i like transaparent :-)
               systemNavigationBarColor: isDarkTheme? BonovaColors.azulNoche[800] :Colors.grey[50], // navigation bar color
               systemNavigationBarDividerColor: isDarkTheme? BonovaColors.azulNoche[800] :Colors.grey[50], // navigation bar color
               statusBarIconBrightness: isDarkTheme? Brightness.light :Brightness.dark, // status bar icons' color
               systemNavigationBarIconBrightness: isDarkTheme? Brightness.light :Brightness.dark, //navigation bar icons' color
        ),
        child: 
        // Scaffold(
        //   // extendBody: true,
        //   body: 
          Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                IndexedStack( 
                  index: currentIndex,
                  children: [
                    InicioPage(),
                    Busqueda(),
                    MisCursos(),
                    Actividad(),
                    UserPage(),
                ]),
                
                FutureBuilder(
                  future: auth.verHistorial(),
                  builder: ( _, AsyncSnapshot<List<Historial>> s){
                    if (s.hasData) {
                      historial = s.data[0];
                      return 
                        !cservice.getDisposed()?
                        minimizable() : Container();
                    } else {
                      return Container();
                    }
                  }
                ),

                _crearBNBar(isDarkTheme),
              ]
          ),
        // ),
      ),
    );
  }

  Widget minimizable() {
    final hist = cservice?.getHistorial();
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 6),
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                        width: double.infinity,
                        height:  52,
                        decoration: BoxDecoration(
                          color: isDarkTheme? BonovaColors.azulNoche[750].withOpacity(.96) : Colors.grey[100].withOpacity(.96), 
                        ),
                        // color: Colors.tealAccent,
                        child: Hero(
                          tag: 'player',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Opacity(
                                opacity: .8,
                                child: Container(
                                  height: 61,
                                  width: 48 * 2.4,
                                  // color: Colors.black,
                                  child: Image.network(
                                   
                                    (hist != null)
                                      ? hist?.curso?.portada?? ''
                                      : historial?.curso?.portada?? '',

                                    fit: BoxFit.cover,
                                  
                                  )
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(top: 10 ),
                                // height: 48 + 60.0,
                                width: 48 * 4.0,
                                // color: Colors.black,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                     
                                      (hist != null && hist.index != null)
                                        ? hist?.curso?.videos[hist?.index??0]?.titulo?? ''
                                        : historial?.curso?.videos[historial?.index??0]?.titulo?? '',
                                      
                                      style: TextStyle( 
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -.3,
                                        // color: Colors.white
                                      ),
                                    ),
                                    SizedBox( height: 3),
                                    Text(
                                     
                                      (hist != null)
                                        ? hist?.curso?.titulo?? ''
                                        : historial?.curso?.titulo?? '',
                                      
                                      style: TextStyle( 
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -.2,
                                        // color: Colors.white
                                      ),
                                    ),
                                    SizedBox( height: 3),

                                  ],
                                )
                              ),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only( right: 0),
                                  child: Icon(FluentIcons.play_24_regular, size: 18),
                                ),
                                onTap: (){
                                  cservice.setDisposed(false);
                                },
                              ), 

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only( right: 20),
                                  child: Icon(FluentIcons.dismiss_24_regular, size: 18),
                                ),
                                onTap: (){
                                  cservice.setDisposed(true);
                                },
                              ), 
                              
                            ]),
                          ),
                        ),
                    hist != null || historial != null?
                      Container(
                        width: double.infinity,
                        height: 2.5,
                        color: isDarkTheme? Colors.white.withOpacity(.03) : Colors.grey[200],
                      )              
                      : Container(),
                    hist != null || historial != null?
                      Container(
                        width: MediaQuery.of(_scaffoldKey.currentContext).size.width * (historial?.index?? 0 + historial.progreso)/historial.curso.videos.length,
                        height: 2.5,
                        color: isDarkTheme? Colors.tealAccent[700] : Colors.teal[400],
                      )              
                      : Container(), 
                  ],
                ),
              ),
              SizedBox( height: 44)
              
            ],
          ),
          onTap: () {
            
            if (hist != null) {
              Navigator.push(_scaffoldKey.currentContext, MaterialPageRoute(builder: (_) => PlayPage( curso: hist?.curso, historial: hist ) ));
              
            } else {
              cservice.setHistorial(historial?? 0);
              Navigator.push(_scaffoldKey.currentContext, MaterialPageRoute(builder: (_) => PlayPage( curso: historial?.curso, historial: historial?? 0 ) ));
            }
            
          },
          ),
    );
  }


  Future cargarUltimo() async {
    final h = await auth.verHistorial();
    historial = h[0]?? '';
    setState(() {});
  }

  // Widget _callPage( int paginaActual ) {
  //   switch( paginaActual ) {
  //     case 0: return InicioPage();
  //     case 1: return Busqueda();
  //     // case 2: return PlayPage(clips: videos);
  //     case 2: return MisCursos();
  //     case 3: return Actividad();
  //     case 4: return UserPage();
  //     default: return InicioPage();
  //   }
  // }




  Widget _crearBNBar(bool dark) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: dark? BonovaColors.azulNoche[800] : Colors.grey[50],
        border: Border( top: BorderSide( width: .1, color: dark? Colors.white60 : Colors.grey[700] ))
      ),
      // padding: EdgeInsets.symmetric( horizontal: 10),
      child: BottomNavigationBar(
        iconSize: 26,
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
                  ? Icon(FluentIcons.play_circle_24_filled, size: 27)
                  : Icon(FluentIcons.play_circle_24_regular, size: 27),
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
                  ? Icon(FluentIcons.person_16_filled, size: 27)
                  : Icon(FluentIcons.person_16_regular, size: 27),
              title: Container()
          ),


          ],
              
      ),
    );
  }
}
