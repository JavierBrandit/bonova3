import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
  
class MisCursos extends StatefulWidget {
  @override
  _MisCursosState createState() => _MisCursosState();
}

class _MisCursosState extends State<MisCursos> {
  List<Curso> misCursos;
  List historial;
  SocketService socketService;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  ScrollController _scrollController;
  final cursoService = CursoService();
  final authService = AuthService();

  @override
  void initState() {

    this.socketService = Provider.of<SocketService>(context, listen: false );

    this.socketService.socket.on('ver-historial', (payload){
      this.historial = ( payload?? '' as List )
          .map( (h) => Historial.fromJson( h ) )
          .toList();
          setState(() {});
      });
    this._cargarMisCursos();

    super.initState();
  }

  @override
  void dispose() { 
    this.socketService.socket.off('ver-historial');
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Continuar Viendo', style: TextStyle( letterSpacing: -.5 )),
      ),
      body:  
 
            (historial != null)? 
                       
              historial.length != 0
                ? _listaCursos()
                : Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Aqui se guardarán todos tus cursos', style: TextStyle( fontSize: 11)),
                      FlatButton(
                        onPressed: (){},
                        color: Colors.teal[900],
                        shape: StadiumBorder(),
                        child: Text('Comenzar uno', style: TextStyle( fontSize: 16))),
                    ],
                  )) 
              
            : Center(child: CircularProgressIndicator( strokeWidth: 1))
            
                    
                    
              
              
              
              
    );
  }

  _cargarMisCursos() async {
    this.historial = await authService.verHistorial();
    setState((){});
  }

  Widget _listaCursos() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _actualizar,
        header: WaterDropHeader(
          // complete: CircleAvatar(backgroundColor: Colors.teal[200].withOpacity(.2), radius: 20 ,child: Icon(FluentIcons.checkmark_circle_24_regular, color: Colors.tealAccent[700], )),
          // idleIcon: CircleAvatar(backgroundColor: Colors.teal[200].withOpacity(.2), radius: 20, child: Icon(FluentIcons.arrow_clockwise_24_regular, color: isDarkTheme? Colors.blueGrey[50] : Colors.grey[700], )),
          waterDropColor: Colors.transparent,
        ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              // height: 270,
              width: double.infinity,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 0),
                physics: BouncingScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // pageSnapping: false,
                itemBuilder: (_, i) => carruselVertical(context, historial[i]),
                itemCount: historial.length,
                controller: _scrollController, 
                separatorBuilder: (_, i) => Divider(color: Colors.grey, indent: 15, endIndent: 15),
              //   controller: PageController(
              //     viewportFraction: 0.57 ), 
              ),
            ),
          ),
        ],
      ),
    );
  }
  _actualizar() async {
    this.historial = await authService.verHistorial();
    setState(() {
          
        });
    _refreshController.refreshCompleted();
  }
}